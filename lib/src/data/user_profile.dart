import "types.dart";

/// A user of the app. Can be a customer or seller.
class UserProfile {
  /// The user's name.
  final String name;
  /// The user's ID.
  final UserID id;

  /// Creates a new User object.
  UserProfile({
    required this.name, 
    required this.id,
  });

  /// Creates a new User object from a JSON object.
  UserProfile.fromJson(Json json) : 
    name = json["name"],
    id = json["id"];

  /// Convert this user to its JSON representation
  Json toJson() => {
    "name": name,
    "id": id,
  };
}
