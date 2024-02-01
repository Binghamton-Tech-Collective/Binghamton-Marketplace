import "types.dart";

/// A notification, for either a user or a seller
class Notification {
  /// The time the notification was sent
  final DateTime timeSent;
  /// The ID of the seller the notification is from
  final SellerID sellerID;
  /// The ID of the product the notification is for, if any
  final ProductID? productID;
  /// The contents of the notification
  final String content;

  /// A constructor to create a new notification.
  const Notification({
    required this.timeSent,
    required this.sellerID,
    required this.content,
    required this.productID,
  });
}
