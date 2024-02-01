import "types.dart";

/// A message, sent from a user to a seller or vice versa
class Message {
  /// The time the message was sent
  final DateTime timeSent;
  /// The contents of the message
  final String content;
  /// The ID of the seller the message is from
  final SellerID author;
  /// The path to the image in the message, if any
  final String? imagePath;
  /// The time the message was edited, if ever
  final DateTime? timeEdited;

  /// A constructor to create a new message.
  const Message({
    required this.timeSent,
    required this.content,
    required this.author,
    required this.imagePath,
    required this.timeEdited,
  });
}
