import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

/// The view model for loading list of all conversations for a user
class ConversationsViewModel extends ViewModel {
  /// The user profile of the user signed in
  final user = models.user.userProfile!;

  /// All the user's archived conversations.
  Set<ConversationID> get archivedIDs => models.user.userProfile!.archivedConversations;

  /// Whether to show archived conversations.
  bool showArchived = false;

  /// Whether the user has no conversations at all.
  bool get isEmpty => models.conversations.allList.isEmpty;

  /// Shows conversations depending on [showArchived].
  List<Conversation> get conversations => showArchived 
    ? models.conversations.archived 
    : models.conversations.unarchived;

  @override
  Future<void> init() async {
    models.conversations.addListener(notifyListeners);
  }

  @override
  void dispose() {
    models.conversations.removeListener(notifyListeners);
    super.dispose();
  }

  /// Toggles whether the UI should show or hide archived conversations.
  // ignore: avoid_positional_boolean_parameters
  void updateShowArchive(bool input) {
    showArchived = input;
    notifyListeners();
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
