import "package:btc_market/data.dart";

/// A conversation between a user and a seller
class Conversation {
  /// The unique ID for a conversation
  final ConversationID id;
  /// The UserID of the buyer involved
  final UserID buyerUID;
  /// The UserID of the seller involved
  final UserID sellerUID;
  /// The Seller of the seller involved
  final SellerID sellerID;
  /// The message history
  final List<Message> messages;

  /// A constructor to create a new Conversation.
  const Conversation({
    required this.id,
    required this.buyerUID,
    required this.sellerUID,
    required this.sellerID,
    required this.messages,
  });

  /// Starts a new conversation between a buyer and a seller.
  factory Conversation.start({
    required ConversationID id,
    required UserProfile buyer,
    required SellerProfile seller,
  }) => Conversation(
    id: id,
    buyerUID: buyer.id,
    sellerUID: seller.userID,
    sellerID: seller.id,
    messages: [],
  );

  /// Creates a new Conversation object from a JSON object.
  Conversation.fromJson(Json json) : 
    id = json["id"],
    buyerUID = json["buyerUID"],
    sellerUID = json["sellerUID"],
    sellerID = json["sellerID"],
    messages = [
      for (final messageJson in json["messages"])
        Message.fromJson(messageJson),
    ];

  /// Convert this Conversation to its JSON representation
  Json toJson() => {
    "id": id,
    "buyerUID": buyerUID,
    "sellerUID": sellerUID,
    "sellerID": sellerID,
    "members": [buyerUID, sellerUID],
    "messages": [
      for (final message in messages)
        message.toJson(),
    ],
  };
}
