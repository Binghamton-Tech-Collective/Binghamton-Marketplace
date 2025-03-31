import "package:btc_market/data.dart";

import "../service.dart";

/// Defines an interface for a database service.
abstract class Database extends Service {
  // ==================== Users ====================

  /// Gets the [UserProfile] for the given user.
  Future<UserProfile?> getUserProfile(UserID userId);

  /// Saves the given user's profile.
  Future<void> saveUserProfile(UserProfile user);

  // ==================== Sellers ====================

  /// Saves the seller's profile to their seller document (in [seller]).
  Future<void> saveSellerProfile(SellerProfile seller);

  /// Returns a new, unique [SellerID].
  SellerID get newSellerID;

  /// Gets the seller profile owned by the given user ID
  Future<SellerProfile?> getSellerProfile(SellerID sellerID);

  /// Gets all the seller profiles owned by the user ID.
  Future<List<SellerProfile>> getSellerProfilesForUser(UserID userID);

  /// Returns a list of all sellers.
  Future<List<SellerProfile>> getAllSellers(UserID id);

  /// Deletes a seller profile and all associated data.
  Future<void> deleteSellerProfile(SellerID id);

  // ==================== Products ====================

  /// Saves a product.
  Future<void> saveProduct(Product product);

  /// Returns a new, unique [ProductID].
  ProductID get newProductID;

  /// Gets a list of products listed by the seller with the given [sellerID].
  Future<List<Product>> getProductsBySellerID(SellerID sellerID);

  /// Gets the product from the the given product ID
  Future<Product?> getProduct(ProductID productID);

  /// Deletes a product from the database.
  Future<void> deleteProduct(ProductID id);

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
  });

  // ==================== Reviews ====================

  /// Gets all the reviews of the seller with the given [sellerID]
  Future<List<Review>> getReviewsBySellerID(SellerID sellerID);

  /// Gets all the reviews about the given product with the given [productID]
  Future<List<Review>> getReviewsByProductID(ProductID productID);

  /// Deletes a review from the database.
  Future<void> deleteReview(ReviewID id);

  // ==================== Conversations ====================

  /// Updates a conversation, including adding messages.
  Future<void> saveConversation(Conversation conversation);

  /// Gets the conversation between the given buyer and seller.
  Future<Conversation?> getConversation(UserProfile buyer, SellerProfile seller);

  /// Subscribes to updates for the given conversation.
  Stream<Conversation?> listenToConversation(ConversationID id);

  /// Gets all conversations that a user is a member of.
  Future<List<Conversation>> getConversationsByUserID(UserID id);

  /// Returns a new, unique [ConversationID].
  ConversationID get newConversationID;

  // ==================== Reports ====================

  /// Returns a new, unique [ReportID].
  ReportID get newReportID;

  /// Saves a user's report.
  Future<void> saveReport(Report report);
}
