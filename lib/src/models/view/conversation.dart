import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:flutter/material.dart";
\
/// The view model for loading a single conversation
class ConversationViewModel extends ViewModel {
  /// ID of the conversation
  final ConversationID id;

  /// Controller to fetch the message
  TextEditingController? messageController;

  /// Constructor for the View model
  ConversationViewModel(this.id);

  /// Conversation object
  late Conversation conversation;

  /// All messages of this conversation
  List<Message> get messages => conversation.messages;

  StreamSubscription<Conversation?>? _subscription;

  /// Add a message to the Conversation
  Future<void> addMessage() async {
    if(messageController!.text.isEmpty) {
      return;
    }
    /// Message object to store in the list of messages for this conversation
    final message = Message(timeSent: DateTime.now(), content: messageController!.text, author: models.user.userProfile!.id);
    conversation.messages.add(message);
    try {
      await services.database.updateConversation(conversation);
    } catch (error) {
      messageError = "Error getting the message:\n$error";
    }
  }

  /// The error when sending or receiving a message, if any
  String? messageError;
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
