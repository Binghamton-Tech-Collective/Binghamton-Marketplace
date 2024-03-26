import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The Chat Page for Conversations
class ConversationPage extends ReactiveWidget<ConversationViewModel> {
  /// Unique ID for the conversation
  final ConversationID id;

  /// Constructor
  const ConversationPage(this.id);

  @override
  ConversationViewModel createModel() => ConversationViewModel(id);

  /// Builds a text field with some shared attributes.
  Widget buildTextField({
    required TextEditingController controller,
    required VoidCallback onSubmit,
    required bool hasBorder,
    String? hint,
    bool autofocus = false,
  }) => TextField(
    autofocus: autofocus,
    controller: controller,
    onSubmitted: (input) => onSubmit(),
    maxLines: null,
    textCapitalization: TextCapitalization.sentences,
    decoration: InputDecoration(
      border: hasBorder ? const UnderlineInputBorder() : InputBorder.none,
      hintText: hint,
      suffix: IconButton(
        icon: const Icon(Icons.send),
        onPressed: onSubmit,
      ),
    ),
  );

  /// Opens a popup to edit a message.
  Future<void> editMessage(BuildContext context, ConversationViewModel model, int index) async {
    final controller = TextEditingController(text: model.reversedMessages[index].content);
    final result = await showAdaptiveDialog<String>(
      context: context, 
      builder: (context) => AlertDialog(
        title: const Text("Edit your message"),
        content: buildTextField(
          controller: controller,
          onSubmit: () => Navigator.of(context).pop(controller.text),
          autofocus: true,
          hasBorder: true,
        ),
      ),
    );
    if (result == null) return;
    await model.editMessage(index, result);
  }

  @override
  Widget build(BuildContext context, ConversationViewModel model) => Scaffold(
    appBar: AppBar(
      title: Row(
        children: [
          Hero(
            tag: "profile-pic-${model.conversation.id}",
            child: CircleAvatar(
              backgroundImage: NetworkImage(model.conversation.otherImage),
            ),
          ),
          const SizedBox(width: 12),
          Text(model.conversation.otherName),
        ],
      ),
    ),
    body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            reverse: true,
            controller: model.scrollController,
            itemCount: model.reversedMessages.length,
            itemBuilder: (context, index) => ChatBubble(
              message: model.reversedMessages[index],
              onEdit: () => editMessage(context, model, index),
              onDelete: () => model.deleteMessage(index),
            ),
          ),
        ),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: buildTextField(
            autofocus: true,
            controller: model.messageController,
            onSubmit: model.addMessage,
            hint: "Type a message...",
            hasBorder: false,
          ),
        ),
      ],
    ),
  );
}
