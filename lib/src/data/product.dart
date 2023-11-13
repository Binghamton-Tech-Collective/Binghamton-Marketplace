import "types.dart";

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

  /// The title or name of the product.
  final String title;
  /// The product's description.
  final String description;
  /// The price of this product
  final double price;
  /// How many of this product are currently available.
  final int quantity;
  /// A list of images to show in this product's page.
  final List<String> imagePaths;
  /// Whether this product has been de-listed.
  /// 
  /// When an item is no longer available, it is still shown but [quantity] will be set to zero.
  /// This is to allow customers to request more of the item from the seller. If the seller wants
  /// to get rid of the listing, they can simply set this to `true` to hide it from buyers. Deleting
  /// a product entirely should also delete its reviews, which can negatively impact the seller's
  /// profile, which is why they might wish to simply delist it instead.
  final bool delisted;

  /// A constructor to create a new product.
  const Product({
    required this.id,
    required this.sellerID,
    required this.title, 
    required this.description, 
    required this.price, 
    required this.quantity, 
    required this.imagePaths, 
    this.delisted = false,
  });
}
