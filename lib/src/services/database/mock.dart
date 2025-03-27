import "dart:async";

import "package:btc_market/data.dart";
import "interface.dart";

/// A mock database that always returns the same hard-coded values.
class MockDatabase extends Database {
  @override
  Future<void> init() async { }

  @override
  Future<UserProfile> getUserProfile(_) async => mockUser;

  @override
  Future<void> saveUserProfile(UserProfile user) async => mockUser = user;

  @override
  Future<void> saveSellerProfile(SellerProfile seller) async => mockSeller = seller;

  @override
  SellerID get newSellerID => mockSeller.id;

  @override
  Future<SellerProfile?> getSellerProfile(SellerID sellerID) async => mockSeller;

  @override
  Future<List<SellerProfile>> getSellerProfilesForUser(UserID userID) async => [mockSeller];

  @override
  Future<List<SellerProfile>> getAllSellers(UserID id) async => [mockSeller];

  @override
  Future<void> deleteSellerProfile(SellerID id) async { }

  @override
  Future<void> saveProduct(Product product) async => mockProduct = product;

  @override
  ProductID get newProductID => mockProduct.id;

  @override
  Future<List<Product>> getProductsBySellerID(SellerID sellerID) async => [mockProduct];

  @override
  Future<Product?> getProduct(ProductID productID) async => mockProduct;

  @override
  Future<void> deleteProduct(ProductID id) async { }

  @override
  Future<List<Product>> queryProducts({
    required int limit,
    required ProductSortOrder sortOrder,
    required ProductFilters filters,
    required String searchQuery,
  }) async => [mockProduct];

  @override
  Future<List<Review>> getReviewsBySellerID(SellerID sellerID) async => [mockReview];

  @override
  Future<List<Review>> getReviewsByProductID(ProductID productID) async => [mockReview];

  @override
  Future<void> deleteReview(ReviewID id) async { }

  @override
  Future<void> saveConversation(Conversation conversation) async => _conversationController.add(conversation);

  @override
  Future<Conversation?> getConversation(UserProfile buyer, SellerProfile seller) async => mockConversation;

  final StreamController<Conversation> _conversationController = StreamController();

  @override
  Stream<Conversation?> listenToConversation(ConversationID id) => _conversationController.stream;

  @override
  Future<List<Conversation>> getConversationsByUserID(UserID id) async => [mockConversation];

  @override
  ConversationID get newConversationID => mockConversation.id;
}
