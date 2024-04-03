import "package:btc_market/data.dart";
import "package:btc_market/services.dart";
import "package:btc_market/models.dart";

import "package:btc_market/pages.dart";

/// The view model for the product page.
class ProductViewModel extends ViewModel {
  /// The product being shown on the page.
  late Product product;

  /// The profile of this product's seller.
  late SellerProfile sellerProfile;

  /// The list of all reviews for this product.
  late List<Review> reviews;

  /// The list of all reviews for this product's seller.
  late List<Review> sellerReviews;

  /// The id of this product.
  ProductID id;

  /// Creates a new view model based on the given product.
  ProductViewModel(this.id);

  /// The average rating of the product, based on [reviews].
  int? get averageRating =>
    reviews.isEmpty ? null : calculateAverageRating(reviews);
  /// The error while opening the conversation, if any.
  String? messageError;
  /// Returning a Conversation
  Future<void> openConversation() async {
    final buyer = models.user.userProfile!;
    final seller = sellerProfile;
    try {
      var conversation = await services.database.getConversation(buyer, sellerProfile);
      if (conversation == null) {
        final conversationID = services.database.conversations.newID;
        conversation = Conversation.start(
          id: conversationID,
          buyer: buyer,
          seller: seller,
        );
        await services.database.saveConversation(conversation);
      }
      await router.push("/messages/${conversation.id}");
    } catch(error) {
      messageError = "There was an error loading the conversations!";
      rethrow;
    }
  }

  /// Function to edit the product
  void editProduct(ProductID id) => router.go("/products/$id/edit");

  /// The average rating for the seller, based on [sellerReviews].
  int? get sellerRating => 
    sellerReviews.isEmpty ? null : calculateAverageRating(sellerReviews);

  @override
  Future<void> init() async {
    errorText = null;
    isLoading = true;
    final tempProduct = await services.database.getProduct(id);
    if (tempProduct == null) {
      errorText = "Could not find product! $id";
      isLoading = false;
      return;
    }
    product = tempProduct;
    final tempSellerProfile = await services.database.getSellerProfile(product.sellerID);
    if (tempSellerProfile == null) {
      errorText = "Could not find sellerID! $product.sellerId";
      isLoading = false;
      return;
    }
    sellerProfile = tempSellerProfile;
    reviews = await services.database.getReviewsByProductID(id);
    sellerReviews = await services.database.getReviewsBySellerID(product.sellerID);
    isLoading = false;
    notifyListeners();
  }
}
