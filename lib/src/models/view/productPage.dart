import "../model.dart";

class ProductPageViewModel extends ViewModel  {
  //Product name
  late String productName;

  //The price
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