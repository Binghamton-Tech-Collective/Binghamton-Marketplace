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
  final int productsPerPage = 200;
  /// Current page number
  //int pageNumber;

  /// Only show products with a [Product.averageRating] at least this high. 
  int minRating = 0;

  /// The sort order to use when displaying products.
  ProductSortOrder sortOrder = ProductSortOrder.byNew;

  /// Whether a search is being performed on the database.
  bool isSearching = false;

  /// Range values for the price filter
  RangeValues priceRange = RangeValues(0, 100);

  /// Current min price
  int get minPrice => priceRange.start.round();

  /// Current max price
  int get maxPrice => priceRange.end.round();

  /// Queries the database using [Database.queryProducts].
  Future<void> queryProducts({String searchQuery = ""}) async {
    isSearching = true;
    productsToShow = await services.database.queryProducts(
      limit: productsPerPage,
      searchQuery: searchQuery.nullIfEmpty,
      categories: categories.nullIfEmpty,
      minRating: minRating == 0 ? null : minRating,
      sortOrder: sortOrder,
      minPrice: minPrice,
      maxPrice: maxPrice,
    );
    isSearching = false;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    await super.init();
    //pageNumber = 0;
    await queryProducts();
  }

  void changePriceRange(RangeValues values) {
    priceRange = values;
    notifyListeners();
    print(priceRange);
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
