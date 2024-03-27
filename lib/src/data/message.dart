import "package:btc_market/data.dart";

/// A message, sent from a user to a seller or vice versa
class Message {
  /// The time the message was sent
  final DateTime timeSent;
  /// The contents of the message
  String content;
  /// The ID of the seller the message is from
  final UserID author;
  /// The path to the image in the message, if any
  final String? imageURL;
  /// The time the message was edited, if ever
  DateTime? timeEdited;

  /// A constructor to create a new message.
  Message({
    required this.author,
    required this.content,
    required this.imageURL,
    required this.timeEdited,
    required this.timeSent,
  });

  /// A new message that's being sent.
  factory Message.send({
    required UserProfile author,
    required String content,
    required String imageURL,
  }) => Message(
    author: author.id,
    content: content,
    imageURL: imageURL,
    timeEdited: null,
    timeSent: DateTime.now(),
  );

  /// Creates a new Message object from a JSON object.
  Message.fromJson(Json json) : 
    timeSent = DateTime.parse(json["timeSent"]),
    content = json["content"],
    author = json["author"],
    imageURL = json["imageURL"],
    timeEdited = json["timeEdited"] != null ? DateTime.parse(json["timeEdited"]) : null;

  /// Convert this Message to its JSON representation
  Json toJson() => {
    "timeSent": timeSent.toIso8601String(),
    "content": content,
    "author": author,
    "imageURL": imageURL,
    "timeEdited": timeEdited?.toIso8601String(),
  };
}
