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
  /// Name of the seller
  final String sellerName;
  /// Name of the buyer
  final String buyerName;
  /// Image of the buyer
  final String buyerImage;
  /// Image of the seller
  final String sellerImage;
  /// The message history
  final List<Message> messages;
  /// The time of the last update. Affects sorting order.
  DateTime lastUpdate;
  /// Status of the conversation
  bool isRead;

  /// A constructor to create a new Conversation.
  Conversation({
    required this.id,
    required this.buyerUID,
    required this.sellerUID,
    required this.sellerID,
    required this.messages,
    required this.buyerName,
    required this.sellerName,
    required this.buyerImage,
    required this.sellerImage,
    required this.lastUpdate,
    required this.isRead,
  });

  /// Starts a new conversation between a buyer and a seller.
  factory Conversation.start({
    required ConversationID id,
    required UserProfile buyer,
    required SellerProfile seller,
    required bool isRead,
  }) => Conversation(
    id: id,
    buyerUID: buyer.id,
    sellerUID: seller.userID,
    sellerID: seller.id,
    buyerName: buyer.name,
    sellerName: seller.name,
    buyerImage: "https://picsum.photos/500",
    sellerImage: seller.imageUrl,
    messages: [],
    lastUpdate: DateTime.now(),
    isRead: isRead,
  );

  /// Creates a new Conversation object from a JSON object.
  Conversation.fromJson(Json json) : 
    id = json["id"],
    buyerUID = json["buyerUID"],
    sellerUID = json["sellerUID"],
    sellerID = json["sellerID"],
    buyerName = json["buyerName"],
    sellerName = json["sellerName"],
    buyerImage = json["buyerImage"],
    sellerImage = json["sellerImage"],
    messages = [
      for (final messageJson in json["messages"])
        Message.fromJson(messageJson),
    ],
    lastUpdate = DateTime.parse(json["lastUpdate"]),
    isRead = json["isRead"] ?? false;

  /// Convert this Conversation to its JSON representation
  Json toJson() => {
    "id": id,
    "buyerUID": buyerUID,
    "sellerUID": sellerUID,
    "sellerID": sellerID,
    "buyerName" : buyerName,
    "sellerName" : sellerName,
    "sellerImage" : sellerImage,
    "buyerImage" : buyerImage,
    "members": [buyerUID, sellerUID],
    "messages": [
      for (final message in messages)
        message.toJson(),
    ],
    "lastUpdate": lastUpdate.toIso8601String(),
    "isRead" : isRead,
  };
}
