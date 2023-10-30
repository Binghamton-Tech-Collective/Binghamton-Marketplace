import "json.dart";

/// A user of the app. Can be a customer or seller.
class User {
  /// The user's name.
  final String name;
  /// The user's ID.
  final int userId;

  /// Creates a new User object.
  User({required this.name, required this.userId});

  /// Creates a new User object from a JSON object.
  User.fromJson(Json json) : 
    name = json["name"],
    userId = json["userId"];

  /// Convert this user to its JSON representation
  Json toJson() => {
    "name": name,
    "userId": userId,
  };
}
