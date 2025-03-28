import "package:btc_market/data.dart";

/// A mock user for testing.
UserProfile mockUser = UserProfile(
  id: const UserID("mock_user_id"),
  imageUrl: "https://picsum.photos/200",
  name: "Mock User",
  archivedConversations: {},
  productsWatchlist: {},
  sellersWatchlist: {},
  theme: ThemeMode.dark,
  token: "mock_user_id",
);

/// A mock seller for testing, owned by [mockUser].
SellerProfile mockSeller = SellerProfile(
  bio: "I am a mock user!",
  id: const SellerID("mock_seller_id"),
  imageUrl: "https://picsum.photos/200",
  name: "Mock Seller",
  userID: mockUser.id,
  contact: const ContactInfo(
    email: "mock@binghamton.edu",
    instagramHandle: "@mockInstagramUser",
    linkedInUsername: "mock_linkedin_user",
    phoneNumber: "+1 (123) 456-7890",
    tikTokUsername: "@mockTikTokUser",
    twitterUsername: "@mockTwitterUser",
  ),
);

/// A mock product for testing, sold by [mockSeller].
Product mockProduct = Product(
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
  sellerID: mockSeller.id,
  title: "Mock Product",
  userID: mockUser.id,
  ratingCount: 10,
  ratingSum: 40,
);

/// A mock review for testing, by [mockUser] for [mockProduct].
Review mockReview = Review(
  authorID: mockUser.id,
  authorName: "Mock reviewer",
  body: "This is a mock review",
  dateTime: DateTime.now(),
  id: const ReviewID("mock_review_id"),
  sellerID: mockSeller.id,
  stars: 3,
  title: "Mock Review",
  productID: mockProduct.id,
);

/// A mock conversation for testing, between [mockUser] and [mockSeller].
Conversation mockConversation = Conversation.start(
  id: const ConversationID("mock_conversation_id"),
  buyer: mockUser,
  seller: mockSeller,
);
