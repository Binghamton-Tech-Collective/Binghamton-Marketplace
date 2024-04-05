import "package:btc_market/data.dart";

/// A class to hold all possible filters by which to search products.
/// 
/// Since our database can only query products based on the same fields as the sort order, this
/// class is split into several subclasses, corresponding to different [ProductSortOrder]s. Be sure
/// to only filter on fields that are being sorted on by the corresponding [ProductSortOrder].
sealed class ProductFilters {
  /// The categories to search for (using logical OR).
  final Set<Category> categories;
  ProductFilters({required this.categories});
}

/// A normal filter, with no additional restrictions.
class NormalFilter extends ProductFilters {
  /// The minimum price to search for. If null, this is ignored.
  final int? minPrice;
  /// The maximum price to search for. If null, this is ignored.
  final int? maxPrice;
  /// The minimum rating to search for. If null, this is ignored.
  final int? minRating;
  
  /// Creates a normal filter with no additional restrictions.
  NormalFilter({
    required super.categories,
    required this.minPrice,
    required this.maxPrice,
    required this.minRating,
  });  
}

/// Filters for [ProductSortOrder.byPriceAscending] and [ProductSortOrder.byPriceDescending].
class FilterByPrice extends ProductFilters {
  /// The minimum price to search for. If null, this is ignored.
  final int? minPrice;
  /// The maximum price to search for. If null, this is ignored.
  final int? maxPrice;

  /// Creates a filter based on price.
  FilterByPrice({
    required this.minPrice, 
    required this.maxPrice, 
    required super.categories,
  });
}

/// Filters for [ProductSortOrder.byRating].
class FilterByRating extends ProductFilters {
  /// The minimum rating to search for. If null, this is ignored.
  final int? minRating;
  
  /// Creates a filter based on ratings.
  FilterByRating({
    required this.minRating, 
    required super.categories,
  });
}
