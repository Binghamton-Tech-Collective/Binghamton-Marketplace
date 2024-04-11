import "package:cloud_firestore/cloud_firestore.dart";

import "package:btc_market/data.dart";

import "firestore.dart";
import "service.dart";

/// A service to interface with our database, Firebase's Cloud Firestore.
class Database extends Service {
  /// The Cloud Firestore plugin.
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// A collection of [UserProfile] objects.
  Collection<UserProfile, UserID> get users => firestore.collection("users").convert(
    fromJson: UserProfile.fromJson,
    toJson: (user) => user.toJson(),
  );

  /// A collection of [SellerProfile] objects.
  Collection<SellerProfile, SellerID> get sellers => firestore.collection("sellers").convert(
    fromJson: SellerProfile.fromJson,
    toJson: (seller) => seller.toJson(),
  );

  /// A collection of [Review] objects.
  Collection<Review, ReviewID> get reviews => firestore.collection("reviews").convert(
    fromJson: Review.fromJson,
    toJson: (review) => review.toJson(),
  );

  /// A collection of [Product] objects.
  Collection<Product, ProductID> get products => firestore.collection("products").convert(
    fromJson: Product.fromJson,
    toJson: (product) => product.toJson(),
  );

  /// A collection of [Product] objects.
  Collection<Conversation, ConversationID> get conversations => firestore.collection("conversations").convert(
    fromJson: Conversation.fromJson,
    toJson: (conversation) => conversation.toJson(),
  );

  @override
  Future<void> init() async { }

  @override
  Future<void> dispose() async { }

  /// Gets the currently signed-in user's profile.
  Future<UserProfile?> getUserProfile(UserID userId) =>
    users.doc(userId).getData();

  /// Saves the user's profile to their user document (in [users]).
  Future<void> saveUserProfile(UserProfile user) =>
    users.doc(user.id).set(user);

  /// Saves the seller's profile to their seller document (in [seller]).
  Future<void> saveSellerProfile(SellerProfile seller) =>
    sellers.doc(seller.id).set(seller);

  /// Saves a product to the database.
  Future<void> saveProduct(Product product) =>
    products.doc(product.id).set(product);

  /// Gets all the reviews of the seller with the given [sellerID]
  Future<List<Review>> getReviewsBySellerID(SellerID sellerID) =>
    reviews.where("sellerID", isEqualTo: sellerID).getAll();

  /// Gets a list of products listed by the seller with the given [sellerID].
  Future<List<Product>> getProductsBySellerID(SellerID sellerID) =>
    products.where("sellerID", isEqualTo: sellerID).getAll();

  /// Gets all the reviews about the given product with the given [productID]
  Future<List<Review>> getReviewsByProductID(ProductID productID) =>
    reviews.where("productID", isEqualTo: productID).getAll();

  /// Gets the seller profile owned by the given user ID
  Future<SellerProfile?> getSellerProfile(SellerID sellerID) =>
    sellers.doc(sellerID).getData();

  /// Gets all the seller profiles owned by the user ID.
  Future<List<SellerProfile>> getSellerProfilesForUser(UserID userID) =>
    sellers.where("userID", isEqualTo: userID).getAll();

  /// Gets the product from the the given product ID
  Future<Product?> getProduct(ProductID productID) =>
    products.doc(productID).getData();

  /// Gets the product from the the given product ID
  Future<Conversation?> getConversationByID(ConversationID conversationID) =>
    conversations.doc(conversationID).getData();

  /// Add the message to database
  Future<void> saveConversation(Conversation conversation) =>
    conversations.doc(conversation.id).set(conversation);

  /// Find the conversation if it already exists
  Future<Conversation?> getConversation(UserProfile buyer, SellerProfile seller) => conversations
    .where("buyerUID", isEqualTo: buyer.id)
    .where("sellerID", isEqualTo: seller.id)
    .where("members", arrayContains: buyer.id)
    .getFirst();

  /// Listens to the conversation with the given id.
  Stream<Conversation?> listenToConversation(ConversationID id) =>
    conversations.doc(id).listen();

  /// Gets all conversations that the user is a member of.
  Future<List<Conversation>> getConversationsByUserID(UserID id) =>
    conversations.where("members", arrayContains: id).getAll();

  /// Gets the list of all sellers
  Future<List<SellerProfile>> getAllSellers(UserID id) =>
    sellers.getAll();

  /// Deletes a review from the database.
  Future<void> deleteReview(ReviewID id) => reviews.doc(id).delete();
  /// Deletes a product from the database.
  Future<void> deleteProduct(ProductID id) => products.doc(id).delete();

  /// Deletes a seller profile and all associated data.
  Future<void> deleteSellerProfile(SellerID id) async {
    // Delete all reviews for this seller and their products.
    final reviews = await getReviewsBySellerID(id);
    for (final review in reviews) {
      await deleteReview(review.id);
    }
    // Delete the seller profile.
    await sellers.doc(id).delete();
  }

  /// Queries products with the given criteria.
  /// 
  /// Firestore has two fundamental limitations that affect how this function works: 
  /// 
  /// 1. There may only be one field on which we use `arrayContainsAny`. This function uses
  /// it for both [searchQuery] and [ProductFilters.categories]. This means that if the search
  /// query is present, this function will choose that over any selected categories. Hopefully,
  /// this will be useful, as a product searched directly should appear no matter what.
  /// 
  /// 2. Only the sort field (ie, we call `orderBy` on it) may have inequality checks. For example,
  /// if you sort products chronologically, then you can't filter for products greater than a certain
  /// price.
  /// 
  /// By combining [sortOrder] and [filters], this function chooses a query that is compatible with
  /// Cloud Firestore's limitations. If a filter is null, it won't affect the query.
  Future<List<Product>> queryProducts({
    required int limit,
    required ProductSortOrder sortOrder,
    required ProductFilters filters,
    required String searchQuery,
  }) async {
    var query = products.limit(limit);
    // Filter by category of search query.
    if (searchQuery.isNotEmpty) {
      final keywords = searchQuery.split(" ").take(20);
      query = query.where("_searchKeywords", arrayContainsAny: keywords);
    } else if (filters.categories.isNotEmpty) {
      query = query.where("categories", arrayContainsAny: [
        for (final category in filters.categories)
          category.id,
        ],
      );
    }
    if (filters.minPrice != null) {
        query = query.where("price", isGreaterThanOrEqualTo: filters.minPrice);
    }
    if (filters.maxPrice != null) {
        query = query.where("price", isLessThanOrEqualTo: filters.maxPrice);
    }
    if (filters.minRating != null) {
        query = query.where("averageRating", isGreaterThanOrEqualTo: filters.minRating);
    }
    // Sort by [ProductSortOrder] option.
    switch (sortOrder) {
      case ProductSortOrder.byPriceAscending:
        query = query.orderBy("price");
      case ProductSortOrder.byPriceDescending:
        query = query.orderBy("price", descending: true);
      case ProductSortOrder.byRating:
        query = query.orderBy("averageRating", descending: true);
      case ProductSortOrder.byNew:
        query = query.orderBy("dateListed", descending: true);
      case ProductSortOrder.byOld:
        query = query.orderBy("dateListed");
    }
    // Execute the query.
    return query.getAll();
  }
}
