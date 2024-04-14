import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

class ConversationsModel extends DataModel {
  /// 
  List<Conversation> all = [];
  Map<ConversationID, Conversation> allMap = {};

  Map<ConversationID, Stream<Conversation?>> streams = {};
  List<StreamSubscription<Conversation?>> _subscriptions = [];

  Set<ConversationID> get _archivedIDs => models.user.userProfile?.archivedConversations ?? {};
  
  /// All non-archived conversations.
  List<Conversation> get unarchived => [
    for (final conversation in all) 
      if (!_archivedIDs.contains(conversation.id))
        conversation,
  ];

  /// All archived conversations.
  List<Conversation> get archived => [
    for (final conversation in all) 
      if (_archivedIDs.contains(conversation.id))
        conversation,
  ];
  
  Future<void> loadConversations() async {
    await stopStreaming();
    final allList = await services.database.getConversationsByUserID(models.user.userID!);
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
    all = allMap.values.toList()..sort();
    notifyListeners();
  }

  Future<void> stopStreaming() async {
    for (final subscription in _subscriptions) {
      await subscription.cancel();
    }
  }

  @override
  void dispose() {
    stopStreaming();
    super.dispose();
  }

  void _update(Conversation? conversation) {
    if (conversation == null) return;
    allMap[conversation.id] = conversation;
    all = allMap.values.toList()..sort();
    notifyListeners();
  }

  Future<void> startConversation(Conversation conversation) async {
    await services.database.saveConversation(conversation);
    all..add(conversation)..sort();
    final id = conversation.id;
    final stream = services.database.listenToConversation(id);
    stream.listen(_update);
    streams[id] = stream;
    notifyListeners();
  }
}
