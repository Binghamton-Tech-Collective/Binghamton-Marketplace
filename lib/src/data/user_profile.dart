import "types.dart";

/// A user of the app. Can be a customer or seller.
class UserProfile {
  /// The user's name.
  final String name;
  /// The user's ID.
  final UserID id;
  /// The products on the user's watchlist
  final Set<ProductID> productsWatchlist;
  /// The sellers on the user's watchlist
  final Set<SellerID> sellersWatchlist;

  /// Creates a new User object.
  UserProfile({
    required this.name, 
    required this.id,
    required this.productsWatchlist,
    required this.sellersWatchlist,
  });

  /// Creates a new profile, with all the default fields.
  UserProfile.newProfile({
    required this.name,
    required this.id,
  }) : 
    productsWatchlist = {},
    sellersWatchlist = {};

  /// Creates a new User object from a JSON object.
  UserProfile.fromJson(Json json) : 
    name = json["name"],
    id = json["id"],
    productsWatchlist = Set<ProductID>.from(json["productsWatchlist"]),
    sellersWatchlist = Set<SellerID>.from(json["sellersWatchlist"]);

  /// Convert this user to its JSON representation
  Json toJson() => {
    "name": name,
    "id": id,
    "productsWatchlist": List<String>.from(productsWatchlist),
    "sellersWatchlist": List<String>.from(sellersWatchlist),
  };

  /// Add a Product to the User's watchlist, by ProductID
  void watchProduct(ProductID product) => productsWatchlist.add(product);
  /// Remove a Product from the User's watchlist, by ProductID
  void unwatchProduct(ProductID product) => productsWatchlist.remove(product);

  /// Add a Seller to the User's watchlist, by SellerID
  void watchSeller(SellerID seller) => sellersWatchlist.add(seller);
  /// Remove a Seller from the User's watchlist, by SellerID
  void unwatchSeller(SellerID seller) => sellersWatchlist.remove(seller);
}
