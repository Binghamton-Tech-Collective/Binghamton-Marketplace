import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

/// The view model for loading list of all conversations for a user
class ConversationsViewModel extends ViewModel {
  /// The user profile of the user signed in
  final user = models.user.userProfile!;

  /// List of all the conversations for the user
  // late List<Conversation> allConversations;

  List<Conversation> get allConversations => [];

  /// All the user's archived conversations.
  Set<ConversationID> get archivedIDs => models.user.userProfile!.archivedConversations;

  /// Whether to show archived conversations.
  bool showArchived = false;

  /// All non-archived conversations.
  List<Conversation> get unarchived => [
    for (final conversation in allConversations)
      if (!archivedIDs.contains(conversation.id))
        conversation,
  ];

  /// All archived conversations.
  List<Conversation> get archived => [
    for (final conversation in allConversations)
      if (archivedIDs.contains(conversation.id))
        conversation,
  ];

  /// Shows conversations depending on [showArchived].
  List<Conversation> get conversations => showArchived ? archived : unarchived;

  /// Toggles whether the UI should show or hide archived conversations.
  // ignore: avoid_positional_boolean_parameters
  void updateShowArchive(bool input) {
    showArchived = input;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    isLoading = true;
    try {
      // allConversations = await services.database.getConversationsByUserID(user.id)..sort(
      //   (a, b) => b.lastUpdate.compareTo(a.lastUpdate),
      // );
    } catch (error) {
      errorText = "Error loading your conversations: \n$error";
      isLoading = false;
      rethrow;
    }
    isLoading = false;
  }

  /// Toggles whether a specific conversation is archived.
  Future<void> toggleArchive(ConversationID id) async {
    if (archivedIDs.contains(id)) {
      archivedIDs.remove(id);
    } else {
      archivedIDs.add(id);
    }
    await services.database.saveUserProfile(user);
    notifyListeners();
  }
}
