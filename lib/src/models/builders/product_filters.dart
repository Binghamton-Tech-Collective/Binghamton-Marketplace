import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/services.dart";
import "package:btc_market/models.dart";

/// A builder model to build a [ProductFilters] based on a given [ProductSortOrder]. 
/// 
/// For reasons discussed at [ProductFilters] and [Database.queryProducts], the sort order
/// limits which filters are available for a query. This builder model tracks all possible
/// filters, and it is up to the UI to hide the non-applicable ones.
class ProductFiltersBuilder extends BuilderModel<ProductFilters> {
  /// A callback when the user asks to search.
  final VoidCallback search;
  /// The set of categories to filter by. Applicable to all sort orders.
  final Set<Category> categories = {};
  /// Creates a builder model to build a [ProductFilters] based on [sortOrder].
  ProductFiltersBuilder(this.search);
  
  /// The chosen sorting order. 
  /// 
  /// Determines which filters are available. See [ProductFilters] and [Database.queryProducts].
  ProductSortOrder sortOrder = ProductSortOrder.byNew;

  /// The minimum rating to filter by, if any. See [FilterByRating.minRating].
  int? minRating;

  /// The minimum price to filter by, if any. See [FilterByPrice.minPrice].
  int? minPrice;

  /// The maximum price to filter by, if any. See [FilterByPrice.maxPrice].
  int? maxPrice;
  
  /// The text controller for [minPrice].
  final minPriceController = TextEditingController();
  
  /// The text controller for [maxPrice].
  final maxPriceController = TextEditingController();

  /// The error with the current [minPrice], if any. Set by [updateMinPrice].
  String? minPriceError;

  /// The error with the current [maxPrice], if any. Set by [updateMaxPrice].
  String? maxPriceError;

  /// Whether either price limit has an error.
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
  ProductFilters build() => NormalFilter(
    categories: categories,
    minPrice: minPrice,
    maxPrice: maxPrice,
    minRating: minRating,
  );

  /// Updates [minPrice] using the value in [minPriceController], and updates [minPriceError].
  void updateMinPrice() {
    minPrice = null;
    minPriceError = null;
    notifyListeners();
    final input = minPriceController.text;
    if (input.isEmpty) return;
    final result = int.tryParse(input);
    if (result == null || result < 0) minPriceError = "Invalid price";
    minPrice = result;
    if (maxPrice != null && minPrice != null && minPrice! >= maxPrice!) minPriceError = "Min price must be less than max price";
    notifyListeners();
  }

  /// Updates [maxPrice] using the value in [maxPriceController], and updates [maxPriceError].
  void updateMaxPrice() {
    maxPrice = null;
    maxPriceError = null;
    notifyListeners();
    final input = maxPriceController.text;
    if (input.isEmpty) return;
    final result = int.tryParse(input);
    if (result == null || result < 0) maxPriceError = "Invalid price";
    maxPrice = result;
    if (minPrice != null && maxPrice != null && minPrice! >= maxPrice!) maxPriceError = "Max price must be greater than min price";
    notifyListeners();
  }

  /// Updates the sort order, and by extension, the filter options available in the UI.
  void updateSortOrder(ProductSortOrder? input) {
    if (input == null) return;
    sortOrder = input;
    notifyListeners();
  }

  /// Updates [minRating].
  void updateMinRating(double rating) {
    minRating = rating == 0 ? null : rating.toInt();
    notifyListeners();
  }

  /// Clears all filters.
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
