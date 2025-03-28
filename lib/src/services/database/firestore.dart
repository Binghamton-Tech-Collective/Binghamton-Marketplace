import "package:cloud_firestore/cloud_firestore.dart";

import "package:btc_market/data.dart";

import "interface.dart";
import "firestore_utils.dart";

/// A service to interface with our database, Firebase's Cloud Firestore.
class FirestoreDatabase extends Database {
  // ==================== Firestore ====================

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

  // ==================== Users ====================

  @override
  Future<UserProfile?> getUserProfile(UserID userId) =>
    users.doc(userId).getData();

  @override
  Future<void> saveUserProfile(UserProfile user) =>
    users.doc(user.id).set(user);

  // ==================== Sellers ====================

  @override
  Future<void> saveSellerProfile(SellerProfile seller) =>
    sellers.doc(seller.id).set(seller);

  @override
  SellerID get newSellerID => sellers.newID;

  @override
  Future<SellerProfile?> getSellerProfile(SellerID sellerID) =>
    sellers.doc(sellerID).getData();

  @override
  Future<List<SellerProfile>> getSellerProfilesForUser(UserID userID) =>
    sellers.where("userID", isEqualTo: userID).getAll();

  @override
  Future<List<SellerProfile>> getAllSellers(UserID id) =>
    sellers.limit(20).getAll();

  @override
  Future<void> deleteSellerProfile(SellerID id) => sellers.doc(id).delete();

  // ==================== Products ====================

  @override
  Future<void> saveProduct(Product product) =>
    products.doc(product.id).set(product);

  @override
  ProductID get newProductID => products.newID;

  @override
  Future<List<Product>> getProductsBySellerID(SellerID sellerID) =>
    products.where("sellerID", isEqualTo: sellerID).limit(20).getAll();

  @override
  Future<Product?> getProduct(ProductID productID) =>
    products.doc(productID).getData();

  @override
  Future<void> deleteProduct(ProductID id) => products.doc(id).delete();

  @override
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

  // ==================== Reviews ====================

  @override
  Future<List<Review>> getReviewsBySellerID(SellerID sellerID) =>
    reviews.where("sellerID", isEqualTo: sellerID).limit(10).getAll();

  @override
  Future<List<Review>> getReviewsByProductID(ProductID productID) =>
    reviews.where("productID", isEqualTo: productID).limit(10).getAll();

  @override
  Future<void> deleteReview(ReviewID id) => reviews.doc(id).delete();

  // ==================== Conversations ====================

  @override
  Future<void> saveConversation(Conversation conversation) =>
    conversations.doc(conversation.id).set(conversation);

  @override
  Future<Conversation?> getConversation(UserProfile buyer, SellerProfile seller) => conversations
    .where("buyerUID", isEqualTo: buyer.id)
    .where("sellerID", isEqualTo: seller.id)
    .where("members", arrayContains: buyer.id)
    .getFirst();

  @override
  Stream<Conversation?> listenToConversation(ConversationID id) =>
    conversations.doc(id).listen();

  @override
  Future<List<Conversation>> getConversationsByUserID(UserID id) =>
    conversations.where("members", arrayContains: id).getAll();

  @override
  ConversationID get newConversationID => conversations.newID;
}
