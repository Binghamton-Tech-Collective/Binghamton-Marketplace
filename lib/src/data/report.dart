

import "package:btc_market/data.dart";

enum ItemType {
  product,
  conversation,
  userProfile,
  sellerProfile;

  @override
  String toString() {
    switch (this) {
      case ItemType.product:
        return "product";
      case ItemType.conversation:
        return "conversation";
      case ItemType.userProfile:
        return "user";
      case ItemType.sellerProfile:
        return "seller";
    }
  }

  factory ItemType.fromString(String s) {
    switch (s) {
      case "product":
        return ItemType.product;
      case "conversation":
        return ItemType.conversation;
      case "user":
        return ItemType.userProfile;
      case "seller":
        return ItemType.sellerProfile;
      default:
        throw Exception("Unreachable");
    }
  }
}

/// A general purpose report
class Report {
  /// The ID of the user who sent this report
  final UserID author;
  /// The reason for the report
  final String reason;
  /// Any additional comments from the user
  final String comment;
  /// The time the report was sent
  final DateTime timeSent;
  /// The ID of the item reported. Type of ID depends on the ItemType
  final String itemID;
  /// The ID of the report
  final ReportID id;
  /// The type of item this report is targeting
  final ItemType type;

  /// A constructor to create a new report
  Report({
    required this.author,
    required this.reason,
    required this.comment,
    required this.itemID,
    required this.type,
    required this.id,
  }) : timeSent = DateTime.now();

  /// Creates a new Report object from a JSON object.
  Report.fromJson(Json json) : 
    author = json["author"],
    reason = json["reason"],
    comment = json["comment"],
    timeSent = DateTime.parse(json["timeSent"]),
    itemID = json["itemID"],
    id = json["id"],
    type = ItemType.fromString(json["type"]);

  /// Convert this Report to its JSON representation
  Json toJson() => {
    "author": author,
    "reason": reason,
    "comment": comment,
    "timeSent": timeSent.toIso8601String(),
    "itemID": itemID,
    "id": id,
    "type": type.toString()
  };
}