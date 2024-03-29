import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// Extension type logics for the frontend code
extension ConversationUtils on Conversation {
  /// To check if the user sending a message is a seller
  bool get isSeller => models.user.userProfile!.id == sellerUID;

  /// Getting the appropriate image based on the role
  String get otherImage => isSeller ? buyerImage : sellerImage;

  /// Getting the appropriate name based on the role
  String get otherName => isSeller ? buyerName : sellerName;

  /// Last message from the conversation, if there is any.
  Message? get lastMessage => messages.lastOrNull;
}

/// Extension types on Message
extension MessageUtils on Message {
  /// Checking if the person sending the message is the author of the message
  bool get isAuthor => author == models.user.userProfile!.id;
}

/// Extension methods for products.
extension ProductUtils on Product {
  /// Whether the currently signed-in user is the seller of this product.
  bool get isSeller => models.user.userProfile!.id == userID;
}
