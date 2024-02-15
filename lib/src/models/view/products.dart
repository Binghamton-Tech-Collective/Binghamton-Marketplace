import "package:btc_market/data.dart";

import "../model.dart";

class ProductsViewModel extends ViewModel {
  List<Product> get allProducts => [];
  Set<Category> get categories => {};
  List<Product> get productsToShow => [];
  
  @override
  Future<void> init() async {
    
  }

  Future<void> search(String query) async {

  }

  Future<void> filterByRating(int numStars) async {

  }

  Future<void> sortByDate() async {

  }

  Future<void> sortByPrice({bool ascending = true}) async {

  }

  Future<void> toggleCategory(Category category) async {

  }

  void openProduct(Product product) {

  }
}
