import "package:btc_market/data.dart";

import "../model.dart";

/// The view model for the product page.
class ProductViewModel extends ViewModel {
  late final Product product;

  /// Stores the information about the Seller
  late final SellerProfile sellerProfile;

  /// Storing the list of all reviews for this particular seller
  late final List<Review> reviews;  

  int? get averageRating => reviews.isEmpty ? null : calculateAverageRating(reviews);

  final ProductID id;
  ProductViewModel(this.id);

  @override
  Future<void> init() async {
    isLoading = true;
    // Download all the needed data

    isLoading = false;
  }
}
