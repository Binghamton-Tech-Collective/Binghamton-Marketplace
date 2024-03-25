import "package:btc_market/data.dart";
import "package:btc_market/pages.dart";
import "package:flutter/material.dart";
import "package:btc_market/services.dart";
import "../model.dart";

/// Product viewmodel
class ProductsViewModel extends ViewModel {
  // List<Product> get allProducts => [];
  /// Currently selected categories
  Set<Category> categories = {};
  /// Currently visible products
  List<Product> productsToShow = [];
  /// Number of products to show per page
  final int productsPerPage = 20;
  /// Search text bar
  TextEditingController searchController = TextEditingController();

  /// Init function
  @override
  Future<void> init() async {
    await super.init();
    searchController.addListener(search);
  }

  /// Dispose function
  @override
  void dispose() {
      searchController.dispose();
      super.dispose();
  }

  /// Searches for a specific search keyword or set of search keywords
  Future<void> search() async {
    isLoading = true;
    productsToShow = await services.database.searchDatabase(
      searchController.text.toLowerCase(),
      categories,
      productsPerPage,
    );
    isLoading = false;
  }

  /// Shows products higher than a rating
  Future<void> filterByRating(int numStars) async {
    isLoading = true;
    productsToShow = await services.database.queryAtLeastRating(
      numStars,
      categories,
      productsPerPage,
    );
    isLoading = false;
  }

  /// Sorts products by date listed
  Future<void> sortByDate() async {
    isLoading = true;
    productsToShow = await services.database.querySortedByDate(
      categories,
      productsPerPage,
    );
    isLoading = false;
  }

  /// Sorts products by price
  Future<void> sortByPrice() async {
    isLoading = true;
    productsToShow = await services.database.querySortedByPrice(
      categories,
      productsPerPage,
    );
    isLoading = false;
  }

  /// Toggles whether a category should be selected
  void toggleCategory(Category category) {
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
  }

  /// Open a given product's page
  void openProduct(ProductID id) {
    router.go("/products/$id");
  }
}
