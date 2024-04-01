import "package:btc_market/data.dart";

sealed class ProductFilters {
  final Set<Category> categories;
  ProductFilters({required this.categories});
}

class NormalFilter extends ProductFilters {
  NormalFilter({required super.categories});
}

class FilterByPrice extends ProductFilters {
  final int? minPrice;
  final int? maxPrice;
  FilterByPrice({
    required this.minPrice, 
    required this.maxPrice, 
    required super.categories,
  });
}

class FilterByRating extends ProductFilters {
  final int? minRating;
  FilterByRating({
    required this.minRating, 
    required super.categories,
  });
}
