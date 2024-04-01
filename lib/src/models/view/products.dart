import "package:btc_market/models.dart";
import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/services.dart";

/// A view model for the products page. 
/// Controls searching, filtering, and sorting the products.
class ProductsViewModel extends ViewModel {
  /// Currently visible products
  List<Product> productsToShow = [];

  /// Number of products to show per page
  final int productsPerPage = 20;

  /// Current page number
  //int pageNumber;

  final searchController = TextEditingController();
  String get searchQuery => searchController.text;
  void clearSearch() {
    searchController.clear();
    queryProducts();
  }

  /// Whether a search is being performed on the database.
  bool isSearching = false;
  
  late final ProductFiltersBuilder filterBuilder;

  /// Queries the database using [Database.queryProducts].
  Future<void> queryProducts() async {
    isSearching = true;
    notifyListeners();
    productsToShow = await services.database.queryProducts(
      limit: productsPerPage,
      filters: filterBuilder.build(),
      sortOrder: filterBuilder.sortOrder,
      searchQuery: searchQuery,
    );
    isSearching = false;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    isLoading = true;
    filterBuilder = ProductFiltersBuilder(queryProducts);
    searchController.addListener(notifyListeners);
    await queryProducts();
    isLoading = false;
  }

  @override
  void dispose() {
    searchController.dispose();
    super.dispose();
  }
}
