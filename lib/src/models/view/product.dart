import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// This view model includes the logic required for the Product View

class ProductViewModel extends ViewModel {
  /// Stores the information about the Product
  late final Product product;

  /// Stores the information about the Seller
  late final SellerProfile sellerProfile;

  /// Storing the list of all reviews for this particular seller
  late final List<Review> reviews;

  /// Stores the id of the product if received
  ProductID? id;

  /// Returns the average rating of the Seller
  double get averageRating => calculateAverageRating(reviews);
}




/**
 * Reference Code
 * class ProductViewModel {
  late final Product product;
  late final SellerProfile profile;
  late final List<Review> reviews;
  final ProductID? id;
  
  bool _isLoading = false;
  bool get isLoading => _isLoading;
  set isLoading(bool value) {
    _isLoading = value;
//     notifyListeners();
  }
  
  ProductViewModel.fromProduct(this.product) : 
    id = null;
  
  ProductViewModel.fromID(this.id);
  
  Future<void> init() async {
    isLoading = true;
    if (id != null) {
      product = await getProduct(id);
    }
    profile = await getSellerProfile();
    reviews = await ...
    isLoading = false;
  }
 */