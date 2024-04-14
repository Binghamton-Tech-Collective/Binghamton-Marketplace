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
  /// All the conversations with this user, in chronologic order.
  List<Conversation> allList = [];
  /// All the conversations with this user, keyed by ID.
  Map<ConversationID, Conversation> allMap = {};

  /// A list of all streams. 
  Map<ConversationID, Stream<Conversation?>> streams = {};
  List<StreamSubscription<Conversation?>> _subscriptions = [];

  Set<ConversationID> get _archivedIDs => models.user.userProfile?.archivedConversations ?? {};
  
  /// All non-archived conversations.
  List<Conversation> get unarchived => [
    for (final conversation in allList) 
      if (!_archivedIDs.contains(conversation.id))
        conversation,
  ];

  /// All archived conversations.
  List<Conversation> get archived => [
    for (final conversation in allList) 
      if (_archivedIDs.contains(conversation.id))
        conversation,
  ];
  
  @override
  Future<void> onSignIn(UserProfile profile) async {
    await onSignOut();  // can't be too careful!
    allList = await services.database.getConversationsByUserID(profile.id)..sort();
    allMap = {
      for (final conversation in allList)
        conversation.id: conversation,
    };
    streams = {
      for (final conversation in allList) 
        conversation.id: services.database.listenToConversation(conversation.id),
    };
    _subscriptions = [
      for (final stream in streams.values)
        stream.listen(_update),
    ];
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
    allMap[conversation.id] = conversation;
    allList = allMap.values.toList()..sort();
    notifyListeners();
  }

  /// Starts a new conversation and listens to it.
  Future<void> startConversation(Conversation conversation) async {
    await services.database.saveConversation(conversation);
    final id = conversation.id;
    final stream = services.database.listenToConversation(id);
    allList..add(conversation)..sort();
    allMap[id] = conversation;
    stream.listen(_update);
    streams[id] = stream;
    notifyListeners();
  }
}
