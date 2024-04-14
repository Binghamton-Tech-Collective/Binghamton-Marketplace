import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

/// A data model to load and listen to conversations. 
/// 
/// By keeping all messages in memory throughout the lifetime of the app,
/// we can support refreshing the conversations page and the conversation
/// page without loading the conversation a second time, or subscribing and
/// unsubscribing.
class ConversationsModel extends DataModel {
  /// A stream for every conversation, keyed by ID.
  final Map<ConversationID, Stream<Conversation?>> streams = {};
  /// A list of subscriptions on each conversation. Be sure to cancel these. 
  final List<StreamSubscription<Conversation?>> _subscriptions = [];
  /// All the conversations this user is a part of, keyed by ID.
  final Map<ConversationID, Conversation> all = {};
  List<Conversation> _allSorted = [];

  void _process(ConversationID id) {
    final stream = services.database.listenToConversation(id);
    final subscription = stream.listen(_update);
    streams[id] = stream;
    _subscriptions.add(subscription);
  }
  
  Set<ConversationID> get _archivedIDs => models.user.userProfile?.archivedConversations ?? {};
  
  /// All non-archived conversations.
  List<Conversation> get unarchived => [
    for (final conversation in _allSorted) 
      if (!_archivedIDs.contains(conversation.id))
        conversation,
  ];

  /// All archived conversations.
  List<Conversation> get archived => [
    for (final conversation in _allSorted) 
      if (_archivedIDs.contains(conversation.id))
        conversation,
  ];
  
  @override
  Future<void> onSignIn(UserProfile profile) async {
    final temp = await services.database.getConversationsByUserID(profile.id);
    for (final conversation in temp) {
      final id = conversation.id;
      _process(id);
    }
    notifyListeners();
  }

  @override
  Future<void> onSignOut() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
  }

  @override
  void dispose() {
    onSignOut();
    super.dispose();
  }

  /// Called when a conversation has been updated.
  void _update(Conversation? conversation) {
    if (conversation == null) return;
    if (all.containsKey(conversation.id)) models.app.showMessage(conversation);
    all[conversation.id] = conversation;
    _allSorted = all.values.toList()..sort();
    notifyListeners();
  }

  /// Starts a new conversation and listens to it.
  Future<void> startConversation(Conversation conversation) async {
    await services.database.saveConversation(conversation);
    _process(conversation.id);
  }
}
