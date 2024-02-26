import "package:btc_market/data.dart";
import "package:btc_market/services.dart";
import "../model.dart";

/// The view model for the product page.
class ProductViewModel extends ViewModel {
  /// The product being shown on the page.
  late final Product product;

  /// The id of this product.
  final ProductID id;

  /// The profile of this product's seller.
  late final SellerProfile sellerProfile;

  /// The list of all reviews for this product.
  late final List<Review> reviews;

  /// The list of all reviews for this product's seller.
  late final List<Review> sellerReviews;

  /// Constructor to initialize the product
  ProductViewModel(this.id);

  /// The average rating of the product, based on [reviews].
  int? get averageRating =>
    reviews.isEmpty ? null : calculateAverageRating(reviews);

  /// The average rating for the seller, based on [sellerReviews].
  int? get sellerRating => 
    sellerReviews.isEmpty ? null : calculateAverageRating(sellerReviews);

  @override
  Future<void> init() async {
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
  }
}
