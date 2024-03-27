import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/services.dart";

import "../model.dart";

/// A view model for the products page. 
/// Controls searching, filtering, and sorting the products.
class ProductsViewModel extends ViewModel {
  /// Currently selected categories
  Set<Category> categories = {};
  /// Currently visible products
  List<Product> productsToShow = [];
  /// Number of products to show per page
  final int productsPerPage = 20;
  /// Search text bar
  TextEditingController searchController = TextEditingController();

  /// The current search query from [searchController].
  String? get searchQuery => searchController.text.nullIfEmpty;
  
  /// Only show products with a [Product.averageRating] at least this high. 
  int minRating = 0;

  /// The sort order to use when displaying products.
  ProductSortOrder sortOrder = ProductSortOrder.byRating;

  /// Whether a search is being performed on the database.
  bool isSearching = false;

  /// Queries the database using [Database.queryProducts].
  Future<void> queryProducts() async {
    isSearching = true;
    productsToShow = await services.database.queryProducts(
      limit: productsPerPage,
      searchQuery: searchQuery,
      categories: categories.nullIfEmpty,
      minRating: minRating,
      sortOrder: sortOrder,
    );
    isSearching = false;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    await super.init();
    searchController.addListener(notifyListeners);
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }

  /// Filters products with a lower rating than this.
  Future<void> filterByRating(int numStars) async {
    minRating = numStars;
    await queryProducts();
  }
  
  /// Changes the sort order for the products.
  Future<void> updateSortOrder(ProductSortOrder input) async {
    sortOrder = input;
    await queryProducts();
  }

  /// Adds or removes a category from the search page.
  Future<void> toggleCategory(Category category) async {
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
    await queryProducts();
  }
}
