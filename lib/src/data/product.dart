import "category.dart";
import "types.dart";

/// The condition of a product.
enum ProductCondition {
  /// A new product, unopened.
  new_("New"),

  /// A used product that is in new condition.
  usedLikeNew("Used (like new)"),

  /// A used product that is in fair condition.
  usedFair("Used (fair)"),

  /// A used product that is in poor condition.
  usedPoor("Used (poor)");

  /// The string to display in the UI.
  final String displayName;

  /// A const constructor.
  const ProductCondition(this.displayName);
}

/// A product being sold on the Marketplace.
///
/// A product can have multiple physical copies available for sale. When it is sold, it is not
/// removed from the marketplace. Instead, the [quantity] is decremented (if it reaches zero, it is
/// marked as "unavailable"). This way, customers can see past products and request the seller make
/// more. If the seller wants to be done with a product, they can de-list it by setting [delisted].
class Product {
  /// This product's unique Product ID.
  final ProductID id;

  /// The seller's unique Seller ID.
  final SellerID sellerID;

  /// The user ID who owns this product and its seller profile.
  final UserID userID;

  /// The title or a name of the product.
  final String title;

  /// The product's description.
  final String description;

  /// The price of this product
  final double price;

  /// The categories in which the Product can be mapped to
  final Set<Category> categories;

  /// How many of this product are currently available.
  final int quantity;

  /// A list of images to show in this product's page.
  final List<String> imageUrls;

  /// Whether this product has been de-listed.
  ///
  /// When an item is no longer available, it is still shown but [quantity] will be set to zero.
  /// This is to allow customers to request more of the item from the seller. If the seller wants
  /// to get rid of the listing, they can simply set this to `true` to hide it from buyers. Deleting
  /// a product entirely should also delete its reviews, which can negatively impact the seller's
  /// profile, which is why they might wish to simply delist it instead.
  final bool delisted;

  /// The condition of the product.
  final ProductCondition condition;

  /// When this product was listed.
  final DateTime dateListed;

  /// The sum of all ratings for the product
  final int ratingSum;

  /// The number of ratings for the product
  final int ratingCount;

  /// The average rating for the product
  final int? averageRating;

  /// A constructor to create a new product.
  const Product({
    required this.id,
    required this.sellerID,
    required this.userID,
    required this.title,
    required this.description,
    required this.price,
    required this.quantity,
    required this.imageUrls,
    required this.categories,
    required this.condition,
    required this.dateListed,
    this.averageRating = 0,
    this.ratingSum = 0,
    this.ratingCount = 0,
    this.delisted = false,
  });

  /// Creates a new Product object from a JSON object.
  Product.fromJson(Json json)
      : id = json["id"],
        sellerID = json["sellerID"],
        userID = json["userID"],
        title = json["title"],
        description = json["description"],
        price = json["price"].toDouble(),
        quantity = json["quantity"],
        imageUrls = List<String>.from(json["imageUrls"]),
        categories = {
          for (final categoryJson in json["categories"])
            Category.fromJson(categoryJson),
        },
        condition = ProductCondition.values.byName(json["condition"]),
        dateListed = DateTime.parse(json["dateListed"]),
        delisted = json["delisted"] ?? false,
        ratingSum = json["ratingSum"] ?? 0,
        ratingCount = json["ratingCount"] ?? 0,
        averageRating = json["averageRating"] ?? 0;

  /// Convert this Product to its JSON representation
  Json toJson() => {
        "id": id,
        "sellerID": sellerID,
        "userID": userID,
        "title": title,
        "_searchKeywords": [
          for (final word in title.split(" ")) 
            word.toLowerCase(),
        ],
        "description": description,
        "price": price,
        "quantity": quantity,
        "imageUrls": imageUrls,
        "categories": [
          for (final category in categories) category.toJson(),
        ],
        "condition": condition.name,
        "dateListed": dateListed.toIso8601String(),
        "delisted": delisted,
        "ratingSum": ratingSum,
        "ratingCount": ratingCount,
        "averageRating": averageRating,
      };
}
