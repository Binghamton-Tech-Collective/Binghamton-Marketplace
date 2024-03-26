import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:flutter/material.dart";

/// Extension type logics for the frontend code
extension ConversationUtils on Conversation {
  /// To check if the user sending a message is a seller
  bool get isSeller => models.user.userProfile!.id == sellerUID;

  /// Getting the appropriate image based on the role
  String get otherImage => isSeller ? buyerImage : sellerImage;

  /// Getting the appropriate name based on the role
  String get otherName => isSeller ? buyerName : sellerName;

  /// Last message from the conversation, if there is any.
  Message? get lastMessage => messages.lastOrNull;
}

/// Extension types on Message
extension MessageUtils on Message {
  /// Checking if the person sending the message is the author of the message
  bool get isAuthor => author == models.user.userProfile!.id;
}

/// The view model for loading a single conversation
class ConversationViewModel extends ViewModel {
  /// ID of the conversation
  final ConversationID id;

  /// Flag to check if the user is editing an existing message or sending a new message
  bool isEditing = false;

  /// Index of the message being edited
  int editingIndex = -1;

  /// Controller to fetch the message
  final messageController = TextEditingController();

  /// Controller to ensure that the latest chat is shown on a new message
  late ScrollController scrollController = ScrollController();

  /// Focus Node to focus the cursor on Text Area
  final messageFocusNode = FocusNode();

  /// Constructor for the View model
  ConversationViewModel(this.id);

  /// Conversation object
  late Conversation conversation;

  /// All messages of this conversation
  List<Message> get messages => conversation.messages;

  StreamSubscription<Conversation?>? _subscription;

  /// Function to scroll the page to bottom

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
  Future<void> deleteMessage(int index) async {
    try {
      conversation.messages.removeAt(index);
      await services.database.saveConversation(conversation);
    } catch (error) {
      messageError = "Could not update message:\n$error";
      rethrow;
    }
  }

  /// Edit a message from the conversation
  Future<void> editMessage(int index) async {
    try {
      if (messageController.text.isEmpty) {
        return;
      }
      conversation.messages[index].content = messageController.text;
      conversation.messages[index].timeEdited = DateTime.now();
      messageController.clear();
      await services.database.saveConversation(conversation);
    } catch (error) {
      messageError = "Could not update message:\n$error";
      rethrow;
    }
  }

  /// The error when sending or receiving a message, if any
  String? messageError;
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
    messageFocusNode.dispose();
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
