import "types.dart";

/// A notification, for either a User or a Seller
class Notification {
  /// The time the Notification was sent
  final DateTime timeSent;
  /// The contents of the Notification
  final String content;
  /// The ID of the seller the Notification is from, if any
  final SellerID? sellerID;
  /// The ID of the product the Notification is for, if any
  final ProductID? productID;

  /// A constructor to create a new Notification.
  const Notification({
    required this.timeSent,
    required this.sellerID,
    required this.content,
    required this.productID,
  });

  /// Creates a new Notification object from a JSON object.
  Notification.fromJson(Json json) : 
    timeSent = DateTime.parse(json["timeSent"]),
    sellerID = json["sellerID"],
    content = json["content"],
    productID = json["productID"];

  /// Convert this Notification to its JSON representation
  Json toJson() => {
    "timeSent": timeSent.toIso8601String(),
    "sellerID": sellerID,
    "content": content,
    "productID": productID,
  };
}
