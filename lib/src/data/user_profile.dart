import "types.dart";
import "product.dart";
import "seller_profile.dart";

/// A user of the app. Can be a customer or seller.
class UserProfile {
  /// The user's name.
  final String name;
  /// The user's ID.
  final UserID id;
  /// The products on the user's watchlist
  final List<Product> productsWatchlist;
  /// The sellers on the user's watchlist
  final List<SellerProfile> sellersWatchlist;

  /// Creates a new User object.
  UserProfile({
    required this.name, 
    required this.id,
    required this.productsWatchlist,
    required this.sellersWatchlist,
  });

  /// Creates a new User object from a JSON object.
  UserProfile.fromJson(Json json) : 
    name = json["name"],
    id = json["id"],
    productsWatchlist = json["productsWatchlist"],
    sellersWatchlist = json["sellersWatchlist"];

  /// Convert this user to its JSON representation
  Json toJson() => {
    "name": name,
    "id": id,
    "productsWatchlist": productsWatchlist,
    "sellersWatchlist": sellersWatchlist,
  };

  void watchProduct(Product product) => productsWatchlist.add(product);
  void unwatchProduct(Product product) => productsWatchlist.remove(product);

  void watchSeller(SellerProfile seller) => sellersWatchlist.add(seller);
  void unwatchSeller(SellerProfile seller) => sellersWatchlist.remove(seller);
}
