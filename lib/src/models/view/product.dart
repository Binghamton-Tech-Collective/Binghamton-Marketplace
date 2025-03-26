import "package:btc_market/data.dart";
import "package:btc_market/services.dart";
import "package:btc_market/models.dart";

import "package:btc_market/pages.dart";

/// The view model for the product page.
class ProductViewModel extends ViewModel {
  /// The product being shown on the page.
  late Product product;

  /// The already-loaded product, if any.
  final Product? initialProduct;

  /// The profile of this product's seller.
  late SellerProfile sellerProfile;

  /// The list of all reviews for this product.
  late List<Review> reviews;

  /// The list of all reviews for this product's seller.
  late List<Review> sellerReviews;

  /// The id of this product.
  ProductID id;

  /// Creates a new view model based on the given product.
  ProductViewModel({
    required this.id,
    required this.initialProduct,
  });

  /// The average rating of the product, based on [reviews].
  int? get averageRating => reviews.isEmpty ? null : calculateAverageRating(reviews);

  /// The error while opening the conversation, if any.
  String? messageError;

  /// Opens or starts a conversation with the seller.
  Future<void> openConversation() async {
    final buyer = models.user.userProfile!;
    final seller = sellerProfile;
    try {
      var conversation = await services.database.getConversation(buyer, sellerProfile);
      if (conversation == null) {
        final conversationID = services.database.newConversationID;
        conversation = Conversation.start(
          id: conversationID,
          buyer: buyer,
          seller: seller,
        );
        await models.conversations.startConversation(conversation);
      }
      await router.push("/messages/${conversation.id}");
    } catch(error) {
      messageError = "There was an error loading the conversations!";
      rethrow;
    }
  }

  /// Function to edit the product
  Future<void> editProduct(ProductID id) async {
    final result = await router.push("/products/$id/edit", extra: product) as Product?;
    if (result == null) return;
    product = result;
    notifyListeners();
  }

  /// The average rating for the seller, based on [sellerReviews].
  int? get sellerRating =>
    sellerReviews.isEmpty ? null : calculateAverageRating(sellerReviews);

  /// Whether the view model is still loading more details about the product.
  ///
  /// Even when this is true, [product] is still available.
  bool loadingDetails = true;

  @override
  Future<void> init() async {
    if (initialProduct != null) {
      product = initialProduct!;
    } else {
      isLoading = true;
      final result = await services.database.getProduct(id);
      isLoading = false;
      if (result == null) {
        errorText = "Could not find product with ID: $id";
        return;
      }
      product = result;
    }
    loadingDetails = true;
    final tempSellerProfile = await services.database.getSellerProfile(product.sellerID);
    if (tempSellerProfile == null) {
      errorText = "Could not find sellerID! $product.sellerId";
      return;
    }
    sellerProfile = tempSellerProfile;
    reviews = await services.database.getReviewsByProductID(id);
    sellerReviews = await services.database.getReviewsBySellerID(product.sellerID);
    loadingDetails = false;
    notifyListeners();
  }
}
