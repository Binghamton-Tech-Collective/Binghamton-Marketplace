import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

class ConversationViewModel extends ViewModel {
  final ConversationID id;
  ConversationViewModel(this.id);

  late Conversation conversation;

  List<Message> get messages => conversation.messages;

  StreamSubscription<Conversation?>? _subscription;

  @override
  Future<void> init() async {
    isLoading = true;
    _subscription = services.database.listenToConversation(id).listen(_update);
  }

  @override
  void dispose() {
    _subscription?.cancel();
    super.dispose();
  }

  void _update(Conversation? data) {
    if (data == null) {
      errorText = "Could not find a conversation with id: $id";
      notifyListeners();
      return;
    }
    conversation = data;
    notifyListeners();
  }
}
