import "package:btc_market/data.dart";
import "package:btc_market/services.dart";
import "../model.dart";

/// The view model for the product page.
class ProductViewModel extends ViewModel {
  /// Product object
  late final Product product;

  /// The id of the product
  final ProductID id;

  /// Stores the information about the Seller
  late final SellerProfile sellerProfile;

  /// Storing the list of all reviews for this particular seller
  late final List<Review> reviews;

  /// Constructor to initialize the product
  ProductViewModel(this.id);

  /// Calculates the average rating of the product
  int? get averageRating =>
      reviews.isEmpty ? null : calculateAverageRating(reviews);

  @override
  Future<void> init() async {
    isLoading = true;
    // services.database.get
    final tempProduct = await services.database.getProduct(id);
    if (tempProduct == null) {
      errorText = "Could not find product! $id";
      isLoading = false;
      return;
    }
    product = tempProduct;
    final tempSellerProfile =
        await services.database.getSellerProfile(product.sellerID);
    if (tempSellerProfile == null) {
      errorText = "Could not find sellerID! $product.sellerId";
      isLoading = false;
      return;
    }
    sellerProfile = tempSellerProfile;
    reviews = await services.database.getReviewsByProductID(id);
    isLoading = false;
  }
}
