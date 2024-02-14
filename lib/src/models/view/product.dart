import "../model.dart";

/// The view model for the product page.
class ProductViewModel extends ViewModel  {
  /// Product name
  late String productName;

  /// The price
  late double productPrice;

  @override
  Future<void> init() async {
    isLoading = true;
    await Future<void>.delayed(const Duration(seconds: 2));
    productName = "Product Title";
    productPrice = 49.99;
    notifyListeners();
    isLoading = false;
  }
}
