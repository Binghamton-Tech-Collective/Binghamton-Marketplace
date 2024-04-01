import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:flutter/material.dart";

class ProductFiltersBuilder extends BuilderModel<ProductFilters> {
  final VoidCallback search;
  final Set<Category> categories = {};
  ProductFiltersBuilder(this.search);
  
  
  ProductSortOrder sortOrder = ProductSortOrder.byNew;
  int? minRating;
  int? minPrice;
  int? maxPrice;
  
  final minPriceController = TextEditingController();
  final maxPriceController = TextEditingController();

  String? minPriceError;
  String? maxPriceError;
  bool get hasPriceError => minPriceError != null || maxPriceError != null;
  
  @override
  Future<void> init() async {
    minPriceController.addListener(updateMinPrice);
    maxPriceController.addListener(updateMaxPrice);
  }

  @override
  void dispose() {
    minPriceController.dispose();
    maxPriceController.dispose();
    super.dispose();
  }
  
  @override
  bool get isReady => !(sortOrder.isByPrice && hasPriceError);

  @override
  ProductFilters build() => switch (sortOrder) {
    ProductSortOrder.byRating => FilterByRating(
      minRating: minRating,
      categories: categories,
    ),
    ProductSortOrder.byNew || ProductSortOrder.byOld => NormalFilter(categories: categories),
    ProductSortOrder.byPriceAscending || ProductSortOrder.byPriceDescending => FilterByPrice(
      minPrice: minPrice, 
      maxPrice: maxPrice,
      categories: categories,
    ),
  };

  void updateMinPrice() {
    minPrice = null;
    minPriceError = null;
    notifyListeners();
    final input = minPriceController.text;
    if (input.isEmpty) return;
    final result = int.tryParse(input);
    if (result == null) minPriceError = "Invalid price";
    minPrice = result;
    notifyListeners();
  }

  void updateMaxPrice() {
    maxPrice = null;
    maxPriceError = null;
    notifyListeners();
    final input = maxPriceController.text;
    if (input.isEmpty) return;
    final result = int.tryParse(input);
    if (result == null) maxPriceError = "Invalid price";
    maxPrice = result;
    notifyListeners();
  }

  void updateSortOrder(ProductSortOrder? input) {
    if (input == null) return;
    sortOrder = input;
    notifyListeners();
  }

  void updateMinRating(double rating) {
    minRating = rating == 0 ? null : rating.toInt();
    notifyListeners();
  }

  void clear() {
    minPrice = null;
    maxPrice = null;
    minPriceError = null;
    maxPriceError = null;
    minPriceController.clear();
    maxPriceController.clear();
    minRating = null;
    sortOrder = ProductSortOrder.byNew;
    categories.clear();
  }

  /// Adds or removes a category from the search page.
  Future<void> toggleCategory(Category category) async {
    if (categories.contains(category)) {
      categories.remove(category);
    } else {
      categories.add(category);
    }
    notifyListeners();
    search();
  }
}
