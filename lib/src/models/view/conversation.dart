import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:flutter/foundation.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

/// The view model for a single conversation.
/// 
/// Loads messages and has functions to send, edit and delete messages.
class ConversationViewModel extends ViewModel {
  /// ID of the conversation
  final ConversationID id;

  /// The initially loaded conversation, if any.
  final Conversation? initialConversation;

  /// Constructor for the View model
  ConversationViewModel(this.id, this.initialConversation);

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

  /// Whether the page is scrolled to the bottom.
  /// 
  /// When the page first loads, on the frame before [scrollController] is attached to a [ListView],
  /// this cannot be determined. In that case, we return true so the page doesn't offer any button.
  bool get isScrolledToBottom => scrollController.hasClients && scrollController.position.pixels == 0;

  StreamSubscription<Conversation?>? _subscription;

  /// The focus node for the text field.
  /// 
  /// This lets us re-request focus when a message is sent.
  final focusNode = FocusNode();
  
  @override
  Future<void> init() async {
    if (initialConversation != null) {
      conversation = initialConversation!;
    } else {
      isLoading = true;
    }
    if (kIsWeb) await BrowserContextMenu.disableContextMenu();
    final tempConversation = await services.database.getConversationByID(id);
    scrollController.addListener(notifyListeners);
    if (tempConversation == null) {
      errorText = "Could not find the conversation! $id";
      isLoading = false;
      return;
    }
    _subscription = services.database.listenToConversation(id).listen(_update);
  }
  
  void _update(Conversation? data) {
    if (data == null) {
      errorText = "Could not find a conversation with id: $id";
      notifyListeners();
      return;
    }
    conversation = data;
    isLoading = false;
  }

  @override
  void dispose() {
    if (kIsWeb) BrowserContextMenu.enableContextMenu();
    _subscription?.cancel();
    super.dispose();
  }

  /// Scrolls to the bottom of the page.
  void scrollToBottom() {
    scrollController.animateTo(
      0,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeOut,
    );
  }

  /// Add a message to the Conversation
  Future<void> send() async {
    if (messageController.text.isEmpty) return;
    /// Message object to store in the list of messages for this conversation
    final message = Message.send(
      content: messageController.text.trim(),
      author: models.user.userProfile!,
      imageURL: "",
    );
    conversation.messages.add(message);
    conversation.lastUpdate = DateTime.now();
    try {
      messageController.clear();
      await services.database.saveConversation(conversation);
      messageController.clear();
    } catch (error) {
      messageError = "Could not send your message:\n$error";
      rethrow;
    }
  }

  /// Delete a message from the conversation
  Future<void> deleteMessage(int reversedIndex) async {
    final index = conversation.messages.length - reversedIndex - 1;
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
    if(message.content == content || content.trim().isEmpty) return;
    message.content = content;
    message.timeEdited = DateTime.now();
    try {
      await services.database.saveConversation(conversation);
    } catch (error) {
      messageError = "Could not update message:\n$error";
      notifyListeners();
    }
  }
}
