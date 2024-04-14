import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// Extension type logics for the frontend code
extension ConversationUtils on Conversation {
  /// To check if the user sending a message is a seller
  bool get isSeller => models.user.userID == sellerUID;

  /// Getting the appropriate image based on the role
  String get otherImage => isSeller ? buyerImage : sellerImage;

  /// Getting the appropriate name based on the role
  String get otherName => isSeller ? buyerName : sellerName;

  /// Last message from the conversation, if there is any.
  Message? get lastMessage => messages.lastOrNull;

  /// A summary of the last message.
  String? get summary => lastMessage == null ? null 
    : "${lastMessage?.getAuthorName(this)}: ${lastMessage?.content.firstLine}";

  /// Whether this conversation should show a notification.
  bool get showNotification => !isRead && !(lastMessage?.isAuthor ?? true);
}

/// Extension types on Message
extension MessageUtils on Message {
  /// Checking if the person sending the message is the author of the message
  bool get isAuthor => author == models.user.userID;

  /// Gets the first name of this message's author.
  String getAuthorName(Conversation conversation) => (
    author == conversation.buyerUID ? conversation.buyerName : conversation.sellerName
  ).split(" ").first;
}

/// Extension methods for products.
extension ProductUtils on Product {
  /// Whether the currently signed-in user is the seller of this product.
  bool get isSeller => models.user.userID == userID;
}

/// Extension methods for sellers.
extension SellerUtils on SellerProfile {
  /// Whether the currently signed-in user is the owner of this profile.
  bool get isUser => models.user.userID == userID;
}
