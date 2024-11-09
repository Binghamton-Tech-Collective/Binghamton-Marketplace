import "package:flutter/material.dart";

import "types.dart";

/// A user of the app. Can be a customer or seller.
class UserProfile {
  /// The user's ID.
  final UserID id;
  /// The user's name.
  final String name;
  /// The user's profile photo.
  final String imageUrl;
  ///
  String? token;
  /// The products on the user's watchlist
  final Set<ProductID> productsWatchlist;
  /// The sellers on the user's watchlist
  final Set<SellerID> sellersWatchlist;
  /// The user's archived conversations.
  final Set<ConversationID> archivedConversations;

  /// The user's theme preference.
  final ThemeMode theme;

  /// Creates a new User object.
  UserProfile({
    required this.id,
    required this.name,
    required this.imageUrl,
    required this.productsWatchlist,
    required this.sellersWatchlist,
    required this.archivedConversations,
    required this.theme,
    this.token,
  });

  /// Creates a new User object from a JSON object.
  UserProfile.fromJson(Json json) :
    name = json["name"],
    id = json["id"],
    imageUrl = json["imageUrl"] ?? "https://picsum.photos/500",
    productsWatchlist = Set<ProductID>.from(json["productsWatchlist"] ?? []),
    sellersWatchlist  = Set<SellerID>.from(json["sellersWatchlist"] ?? []),
    archivedConversations = Set<ConversationID>.from(json["archivedConversations"] ?? []),
    token = json["token"],
    theme = json["theme"] == null ? ThemeMode.system : ThemeMode.values.byName(json["theme"]);

  /// Convert this user to its JSON representation
  Json toJson() => {
    "id": id,
    "name": name,
    "imageUrl": imageUrl,
    "productsWatchlist": List<String>.from(productsWatchlist),
    "sellersWatchlist": List<String>.from(sellersWatchlist),
    "archivedConversations": List<String>.from(archivedConversations),
    "theme": theme.name,
    "token" : token,
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
