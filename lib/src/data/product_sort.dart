import "product.dart";

/// A custom sort order based on fields in each [Product].
enum ProductSortOrder {
  /// Sorts by [Product.price], in ascending order (lowest prices first).
  byPriceAscending("Price (low to high)"),
  /// Sorts by [Product.price], in descending order (highest prices first).
  byPriceDescending("Price (high to low)"),
  /// Sorts by [Product.averageRating], in ascending order.
  byRating("Average Rating"),
  /// Sorts by [Product.dateListed], with recent items first.
  byNew("Newest"),
  /// Sorts by [Product.dateListed], with older items first.
  byOld("Oldest");

  /// The UI-friendly name to show for this sort order.
  final String displayName;
  const ProductSortOrder(this.displayName);
}
