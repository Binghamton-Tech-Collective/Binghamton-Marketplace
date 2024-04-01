import "package:btc_market/data.dart";

class ProductFilters {
  Set<Category> categories = {};
  int? minRating;
  String? searchQuery;
  int? minPrice;
  int? maxPrice;
}
