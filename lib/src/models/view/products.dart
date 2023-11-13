import "package:btc_market/data.dart";

import "../model.dart";

class ProductsViewModel extends ViewModel {
  final List<Product> products = [];
  final List<Product> hotProducts = [];
  List<String> tags = [];

  @override
  Future<void> init() async {
    isLoading = true;
    // load all the data from the database
    isLoading = false;
  }
}