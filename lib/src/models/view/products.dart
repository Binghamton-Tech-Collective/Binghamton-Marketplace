import "package:flutter/material.dart";

import "package:btc_market/data.dart";
<<<<<<< HEAD
import "package:btc_market/services.dart";

import "../model.dart";

/// A view model for the products page. 
/// 
/// Controls searching, filtering, and sorting the products.
class ProductsViewModel extends ViewModel {
=======
import "package:btc_market/pages.dart";
import "package:flutter/material.dart";
import "package:btc_market/services.dart";
import "../model.dart";

/// Product viewmodel
class ProductsViewModel extends ViewModel {
  // List<Product> get allProducts => [];
>>>>>>> origin/Home_UI
  /// Currently selected categories
  Set<Category> categories = {};
  /// Currently visible products
  List<Product> productsToShow = [];
  /// Number of products to show per page
  final int productsPerPage = 20;
  /// Search text bar
  TextEditingController searchController = TextEditingController();
<<<<<<< HEAD

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
=======

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
>>>>>>> origin/Home_UI
  }
}
