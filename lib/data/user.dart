import "json.dart";

class User {
  final String name;
  final int userId;
  final bool isAdmin;

  User({required this.name, required this.userId, required this.isAdmin});

  User.fromJson(Json json) : 
    name = json["name"],
    userId = json["userId"],
    isAdmin = json["isAdmin"];

  Json toJson() => {
    "name": name,  // String
    "userId": userId,  // int 
    "isAdmin": isAdmin,  // bool
  };
}
