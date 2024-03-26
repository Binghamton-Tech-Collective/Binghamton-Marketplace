import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:flutter/material.dart";

/// The view model for a single conversation.
// TODO: Document a bit more here.
class ConversationViewModel extends ViewModel {
  /// ID of the conversation
  final ConversationID id;

  /// Constructor for the View model
  ConversationViewModel(this.id);

  /// Controller to fetch the message
  final messageController = TextEditingController();

  /// A scroll controller so we can scroll to the bottom
  late ScrollController scrollController = ScrollController();

  /// The error when sending or receiving a message, if any
  String? messageError;

  /// Conversation object
  late Conversation conversation;

  /// All messages of this conversation
  List<Message> get reversedMessages => conversation.messages.reversed.toList();

  StreamSubscription<Conversation?>? _subscription;

  /// Scrolls to the bottom of the page.
  void scrollToBottom() {
    scrollController.animateTo(
      scrollController.position.maxScrollExtent,
      duration: const Duration(milliseconds: 50),
      curve: Curves.easeOut,
    );
  }

  /// Add a message to the Conversation
  Future<void> addMessage() async {
    if (messageController.text.isEmpty) {
      return;
    }

    /// Message object to store in the list of messages for this conversation
    final message = Message(
      timeSent: DateTime.now(),
      content: messageController.text,
      author: models.user.userProfile!.id,
      imageURL: "",
      timeEdited: null,
    );
    conversation.messages.add(message);
    try {
      messageController.clear();
      await services.database.saveConversation(conversation);
      notifyListeners();
    } catch (error) {
      messageError = "Could not send your message:\n$error";
      rethrow;
    }
  }

  /// Delete a message from the conversation
  Future<void> deleteMessage(int reversedIndex) async {
    // The messages are displayed in reverse. We need to un-reverse it
    final index = conversation.messages.length - 1 - reversedIndex;
    try {
      conversation.messages.removeAt(index);
      await services.database.saveConversation(conversation);
    } catch (error) {
      messageError = "Could not update message:\n$error";
      rethrow;
    }
  }

  /// Edits the message at the given index.
  Future<void> editMessage(int reversedIndex, String content) async {
    final message = reversedMessages[reversedIndex];
    message.content = content;
    message.timeEdited = DateTime.now();
    try {
      await services.database.saveConversation(conversation);
    } catch (error) {
      messageError = "Could not update message:\n$error";
      notifyListeners();
    }
  }

  @override
  Future<void> init() async {
    isLoading = true;
    final tempConversation = await services.database.getConversationByID(id);
    if (tempConversation == null) {
      errorText = "Could not find the conversation! $id";
      isLoading = false;
      return;
    }
    conversation = tempConversation;
    _subscription = services.database.listenToConversation(id).listen(_update);
    isLoading = false;
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
