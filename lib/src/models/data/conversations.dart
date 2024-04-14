import "dart:async";

import "package:flutter/services.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

class ConversationData implements Comparable<ConversationData> {
  ConversationID id;
  Conversation? data;
  VoidCallback callback;
  late Stream<Conversation?> stream;
  // ignore: cancel_subscriptions
  late final StreamSubscription<Conversation?> subscription;

  ConversationData({
    required this.id,
    required this.callback,
  }) {
    stream = services.database.listenToConversation(id);
    subscription = stream.listen(_update);
  }

  void _update(Conversation? value) {
    if (value == null) return;
    data = value;
    callback();
  }

  @override
  int compareTo(ConversationData other) => (data == null || other.data == null)
    ? id.compareTo(other.id) : data!.compareTo(other.data!);
} 

/// A data model to load and listen to conversations. 
/// 
/// By keeping all messages in memory throughout the lifetime of the app,
/// we can support refreshing the conversations page and the conversation
/// page without loading the conversation a second time, or subscribing and
/// unsubscribing.
class ConversationsModel extends DataModel {

  Map<ConversationID, ConversationData> allMap = {};
  List<Conversation> allList = [];
  
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
    await onSignOut();
    final temp = await services.database.getConversationsByUserID(profile.id);
    allMap = {
      for (final conversation in temp)
        conversation.id: ConversationData(id: conversation.id, callback: _update),
    };
    notifyListeners();
  }

  @override
  Future<void> onSignOut() async {
    for (final data in allMap.values) {
      await data.subscription.cancel();
    }
  }

  @override
  void dispose() {
    onSignOut();
    super.dispose();
  }

  /// Called when a conversation has been updated.
  void _update() {
    allList = [
      for (final conversation in allMap.values)
        conversation.data!,
    ]..sort();
    notifyListeners();
  }

  /// Starts a new conversation and listens to it.
  Future<void> startConversation(Conversation conversation) async {
    await services.database.saveConversation(conversation);
    final data = ConversationData(id: conversation.id, callback: _update);
    allMap[conversation.id] = data;
    _update();
  }
}
