import "types.dart";
import "message.dart";

/// A conversation between a user and a seller
class Conversation {
  /// The UserID of the buyer involved
  final UserID buyerUID;
  /// The UserID of the seller involved
  final UserID sellerUID;
  /// The Seller of the seller involved
  final SellerID sellerID;
  /// The message history
  final List<Message> messages;
  /// The ID of the product being discussed, if any
  final ProductID? productID;

  /// A constructor to create a new Conversation.
  const Conversation({
    required this.buyerUID,
    required this.sellerUID,
    required this.sellerID,
    required this.messages,
    required this.productID,
  });

  /// Creates a new Conversation object from a JSON object.
  Conversation.fromJson(Json json) : 
    buyerUID = json["buyerUID"],
    sellerUID = json["sellerUID"],
    sellerID = json["sellerID"],
    messages = [
      for (final messageJson in json["messages"])
          Message.fromJson(messageJson),
    ],
    productID = json["productID"];

  /// Convert this Conversation to its JSON representation
  Json toJson() => {
    "buyerUID": buyerUID,
    "sellerUID": sellerUID,
    "sellerID": sellerID,
    "messages": [
      for (final message in messages)
          message.toJson(),
    ],
    "productID": productID,
  };

  /// Add a [Message] to the conversation (generally by sending a new one)
  void addMessage(Message message) => messages.add(message);

  /// Remove a [Message] from the conversation
  void remove(Message message) => messages.remove(message);
}
