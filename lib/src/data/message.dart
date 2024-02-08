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

  /// Creates a new Message object from a JSON object.
  Message.fromJson(Json json) : 
    timeSent = json["timeSent"],
    content = json["content"],
    author = json["author"],
    imagePath = json["imagePath"],
    timeEdited = json["timeEdited"];

  /// Convert this Message to its JSON representation
  Json toJson() => {
    "timeSent": timeSent,
    "content": content,
    "author": author,
    "imagePath": imagePath,
    "timeEdited": timeEdited,
  };
   
  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;
    return timeSent == other.timeSent &&
           timeEdited == other.timeEdited &&
           author == other.author &&
           imagePath == other.imagePath &&
           content == other.content;
  }

  @override
  int get hashCode => (((timeSent.hashCode * 31 + timeEdited.hashCode) * 31 +
              author.hashCode) * 31 + imagePath.hashCode) * 31 +
              content.hashCode;
}
