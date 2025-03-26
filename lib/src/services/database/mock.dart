import "dart:async";

import "package:btc_market/data.dart";
import "interface.dart";

UserProfile _mockUser = UserProfile(
  id: const UserID("mock_user_id"),
  imageUrl: "https://picsum.photos/200",
  name: "Mock User",
  archivedConversations: {},
  productsWatchlist: {},
  sellersWatchlist: {},
  theme: ThemeMode.dark,
  token: "mock_user_id",
);

SellerProfile _mockSeller = SellerProfile(
  bio: "I am a mock user!",
  id: const SellerID("mock_seller_id"),
  imageUrl: "https://picsum.photos/200",
  name: "Mock Seller",
  userID: _mockUser.id,
  contact: const ContactInfo(
    email: "mock@gmail.com",
    instagramHandle: "@mockInstaUser",
    linkedInUsername: "mock_linkedin_user",
    phoneNumber: "+1 (123) 456-7890",
    tikTokUsername: "@mockTikTokUser",
    twitterUsername: "@mockTwitterUser",
  ),
);

Product _mockProduct = Product(
  categories: {Category.clothes},
  condition: ProductCondition.new_,
  dateListed: DateTime.now(),
  description: "This is a mock description",
  id: const ProductID("mock_product_id"),
  imageUrls: [
    "https://picsum.photos/200",
    "https://picsum.photos/300",
    "https://picsum.photos/400",
  ],
  price: 2000,
  quantity: 3,
  sellerID: _mockSeller.id,
  title: "Mock Product",
  userID: _mockUser.id,
  ratingCount: 10,
  ratingSum: 40,
);

Review _mockReview = Review(
  authorID: _mockUser.id,
  authorName: "Mock reviewer",
  body: "This is a mock review",
  dateTime: DateTime.now(),
  id: const ReviewID("mock_review_id"),
  sellerID: _mockSeller.id,
  stars: 3,
  title: "Mock Review",
  productID: _mockProduct.id,
);

Conversation _mockConversation = Conversation.start(
  id: const ConversationID("mock_conversation_id"),
  buyer: _mockUser,
  seller: _mockSeller,
);

/// A mock database that always returns the same hard-coded values.
class MockDatabase extends Database {
  @override
  Future<void> init() async { }

  @override
  Future<void> dispose() async { }

  @override
  Future<UserProfile> getUserProfile(_) async => _mockUser;

  @override
  Future<void> saveUserProfile(UserProfile user) async => _mockUser = user;

  @override
  Future<void> saveSellerProfile(SellerProfile seller) async => _mockSeller = seller;

  @override
  SellerID get newSellerID => _mockSeller.id;

  @override
  Future<SellerProfile?> getSellerProfile(SellerID sellerID) async => _mockSeller;

  @override
  Future<List<SellerProfile>> getSellerProfilesForUser(UserID userID) async => [_mockSeller];

  @override
  Future<List<SellerProfile>> getAllSellers(UserID id) async => [_mockSeller];

  @override
  Future<void> deleteSellerProfile(SellerID id) async { }

  @override
  Future<void> saveProduct(Product product) async => _mockProduct = product;

  @override
  ProductID get newProductID => _mockProduct.id;

  @override
  Future<List<Product>> getProductsBySellerID(SellerID sellerID) async => [_mockProduct];

  @override
  Future<Product?> getProduct(ProductID productID) async => _mockProduct;

  @override
  Future<void> deleteProduct(ProductID id) async { }

  @override
  Future<List<Product>> queryProducts({
    required int limit,
    required ProductSortOrder sortOrder,
    required ProductFilters filters,
    required String searchQuery,
  }) async => [_mockProduct];

  @override
  Future<List<Review>> getReviewsBySellerID(SellerID sellerID) async => [_mockReview];

  @override
  Future<List<Review>> getReviewsByProductID(ProductID productID) async => [_mockReview];

  @override
  Future<void> deleteReview(ReviewID id) async { }

  @override
  Future<void> saveConversation(Conversation conversation) async => _conversationController.add(conversation);

  @override
  Future<Conversation?> getConversation(UserProfile buyer, SellerProfile seller) async => _mockConversation;

  final StreamController<Conversation> _conversationController = StreamController();

  @override
  Stream<Conversation?> listenToConversation(ConversationID id) => _conversationController.stream;

  @override
  Future<List<Conversation>> getConversationsByUserID(UserID id) async => [_mockConversation];

  @override
  ConversationID get newConversationID => _mockConversation.id;
}
