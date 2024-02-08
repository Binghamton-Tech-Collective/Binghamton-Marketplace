import "types.dart";
import "package:meta/meta.dart";

/// A message, sent from a user to a seller or vice versa
@immutable
class Message {
  /// The time the message was sent
  final DateTime timeSent;
  /// The contents of the message
  final String content;
  /// The ID of the seller the message is from
  final SellerID author;
  /// The path to the image in the message, if any
  final String? imageURL;
  /// The time the message was edited, if ever
  final DateTime? timeEdited;

  /// A constructor to create a new message.
  const Message({
    required this.timeSent,
    required this.content,
    required this.author,
    required this.imageURL,
    required this.timeEdited,
  });

  /// Creates a new Message object from a JSON object.
  Message.fromJson(Json json) : 
    timeSent = DateTime.parse(json["timeSent"]),
    content = json["content"],
    author = json["author"],
    imageURL = json["imageURL"],
    timeEdited = DateTime.parse(json["timeEdited"]);

  /// Convert this Message to its JSON representation
  Json toJson() => {
    "timeSent": timeSent.toIso8601String(),
    "content": content,
    "author": author,
    "imageURL": imageURL,
    "timeEdited": timeEdited?.toIso8601String(),
  };
   
  @override
  bool operator ==(covariant Message other) {
    if (identical(this, other)) return true;
    return timeSent == other.timeSent &&
           timeEdited == other.timeEdited &&
           author == other.author &&
           imageURL == other.imageURL &&
           content == other.content;
  }

  @override
  int get hashCode => (((timeSent.hashCode * 31 + timeEdited.hashCode) * 31 +
              author.hashCode) * 31 + imageURL.hashCode) * 31 +
              content.hashCode;
}
