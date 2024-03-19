import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

/// The view model for loading a single conversation
class ConversationViewModel extends ViewModel {
  /// ID of the conversation
  final ConversationID id;

  /// Constructor for the View model
  ConversationViewModel(this.id);

  /// Conversation object
  late Conversation conversation;

  /// All messages of this conversation
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
