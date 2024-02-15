import "package:btc_market/data.dart";
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
    // this.product = getProduct(this.id);
    // sellerProfile = await getSellerProfile(this.product.sellerID);
    // reviews = await getReviews(this.id);
    isLoading = false;
  }
}
