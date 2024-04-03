import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

/// The view model for loading list of all conversations for a user
class ConversationsViewModel extends ViewModel {
  /// The user profile of the user signed in
  final user = models.user.userProfile!;

  /// List of all the conversations for the user
  late List<Conversation> allConversations;

  @override
  Future<void> init() async {
    isLoading = true;
    try {
      allConversations = await services.database.getConversationsByUserID(user.id)..sort(
        (a, b) => b.lastUpdate.compareTo(a.lastUpdate),
      );
    } catch (error) {
      errorText = "Error loading your conversations: \n$error";
      isLoading = false;
      rethrow;
    }
    isLoading = false;
  }
}
