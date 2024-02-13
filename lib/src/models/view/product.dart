import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// This view model includes the logic required for the Product View

class ProductViewModel extends ViewModel {
  /// Stores the information about the Product
  late final Product product;

  /// Stores the information about the Seller
  late final SellerProfile profile;

  /// Storing the list of all reviews for this particular seller
  late final List<Review> reviews;

  /// Stores the id of the product if received
  ProductID? id;

  /// Returns the average rating of the Seller

  double get averageRating => profile.calculateAverageRating();
}
