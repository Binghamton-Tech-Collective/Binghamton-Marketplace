import "package:btc_market/data.dart";
import "package:flutter/material.dart";

import "../model.dart";

class ProductsViewModel extends ViewModel {
  // List<Product> get allProducts => [];
  Set<Category> get categories => {};
  List<Product> productsToShow = [];
  
  TextEditingController searchController = TextEditingController();

  @override
  Future<void> init() async {
    searchController.addListener(search);
  }

  void dispose() {
      searchController.dispose();
  }

  Future<void> search() async {
    _isLoading = true;
    productsToShow = searchDatabase(searchController.text.toLowerCase());
    _isLoading = false;
  }

  Future<void> filterByRating(int numStars) async {
    isLoading = true;
    productsToShow = queryByRating(numStars);
    isLoading = false;
  }

  Future<void> sortByDate() async {
    isLoading = true;
    productsToShow = querySortedByDate();
    isLoading = false;
  }

  Future<void> sortByPrice() async {
    isLoading = true;
    productsToShow = querySortedByPrice(numStars);
    isLoading = false;
  }

  Future<void> toggleCategory(Category category) async {

  }

  void openProduct(Product product) {

  }
}
