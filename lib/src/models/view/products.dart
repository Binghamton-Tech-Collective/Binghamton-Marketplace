import "package:btc_market/data.dart";

import "../model.dart";

/// A view model to store all the products on the products page.
class ProductsViewModel extends ViewModel {
  /// All the products.
  final List<Product> products = [];
  /// The hot or recently viewed products.
  final List<Product> hotProducts = [];
  /// The currently selected tags to filter on.
  List<String> tags = [];

  @override
  Future<void> init() async {
    isLoading = true;
    // load all the data from the database
    isLoading = false;
  }
}
