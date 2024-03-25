import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

/// Extension type logics for the frontend code
extension ConversationsUtils on Conversation {
  /// To check if the user sending a message is a seller
  bool get isSeller => models.user.userProfile!.id == sellerUID;

  /// Getting the appropriate image based on the role
  String get conversationImage => isSeller ? buyerImage : sellerImage;

  /// Getting the appropriate name based on the role
  String get conversationName => isSeller ? buyerName : sellerName;

  /// Last message from the conversation
  Message? get lastMessage =>
      messages.isEmpty ? null : messages[messages.length - 1];
}

/// The view model for loading list of all conversations for a user
class ConversationsViewModel extends ViewModel {
  /// The user profile of the user signed in
  final user = models.user.userProfile;

  /// List of all the conversations for the user
  late List<Conversation> allConversations;

  /// The error when fetching any conversations, if any
  String? conversationsError;

  @override
  Future<void> init() async {
    isLoading = true;
    try {
      allConversations =
          await services.database.getConversationsByUserID(user!.id);

      allConversations.sort(
        (a, b) => b.lastMessage!.timeSent.compareTo(a.lastMessage!.timeSent),
      );
    } catch (error) {
      conversationsError = "Error loading the conversations: \n$error!";
      isLoading = false;
      rethrow;
    }
    isLoading = false;
  }
}
