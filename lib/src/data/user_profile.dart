import "json.dart";

/// A user of the app. Can be a customer or seller.
class UserProfile {
  /// The user's name.
  final String name;
  /// The user's ID.
  final String id;
  /// The number of likes this user has.
  int numLikes;

  /// Creates a new User object.
  UserProfile({
    required this.name, 
    required this.id,
    required this.numLikes,
  });

  /// Creates a new User object from a JSON object.
  UserProfile.fromJson(Json json) : 
    name = json["name"],
    numLikes = json["numLikes"],
    id = json["id"];

  /// Convert this user to its JSON representation
  Json toJson() => {
    "name": name,
    "numLikes": numLikes,
    "id": id,
  };
}
