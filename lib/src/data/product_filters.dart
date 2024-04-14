import "package:btc_market/data.dart";

/// A class to hold all possible filters by which to search products.
/// 
/// Since our database can only query products based on the same fields as the sort order, this
/// class is split into several subclasses, corresponding to different [ProductSortOrder]s. Be sure
/// to only filter on fields that are being sorted on by the corresponding [ProductSortOrder].
class ProductFilters {
  /// The categories to search for (using logical OR).
  final Set<Category> categories;
  /// The minimum price to search for. If null, this is ignored.
  final int? minPrice;
  /// The maximum price to search for. If null, this is ignored.
  final int? maxPrice;
  /// The minimum rating to search for. If null, this is ignored.
  final int? minRating;

  /// Creates a normal filter with no additional restrictions.
  ProductFilters({
    required this.categories,
    required this.minPrice,
    required this.maxPrice,
    required this.minRating,
  });  
}
