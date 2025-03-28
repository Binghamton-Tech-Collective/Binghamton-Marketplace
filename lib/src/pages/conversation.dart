import "package:flutter/foundation.dart";
import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/services.dart";

/// The Chat Page for Conversations.
class ConversationPage extends ReactiveWidget<ConversationViewModel> {
  /// Unique ID for the conversation
  final ConversationID id;

  /// The already loaded conversation, if any.
  ///
  /// This will be null if this page is loaded through a URL.
  final Conversation? initialConversation;

  /// Constructor
  const ConversationPage(this.id, this.initialConversation);

  @override
  ConversationViewModel createModel() => ConversationViewModel(id, initialConversation);

  @override
  void didUpdateWidget(ConversationPage oldWidget, ConversationViewModel model) {
    if (oldWidget.id != id) {
      model.reset(id);
      model.init();
    }
    super.didUpdateWidget(oldWidget, model);
  }

  /// Builds a text field with some shared attributes.
  Widget buildTextField({
    required TextEditingController controller,
    required VoidCallback onSubmit,
    required bool hasBorder,
    FocusNode? focusNode,
    String? hint,
    bool autofocus = false,
  }) => Row(children: [
    Expanded(child: TextField(
      autofocus: autofocus,
      controller: controller,
      focusNode: focusNode,
      keyboardType: TextInputType.multiline,
      textInputAction: kIsWeb ? TextInputAction.send : TextInputAction.newline,
      maxLines: null,
      textCapitalization: TextCapitalization.sentences,
      onEditingComplete: () {
        if (!HardwareKeyboard.instance.isShiftPressed) onSubmit();
      },
      decoration: InputDecoration(
        border: hasBorder ? const UnderlineInputBorder() : InputBorder.none,
        hintText: hint,
      ),
    ),),
    IconButton(
      icon: const Icon(Icons.send),
      onPressed: onSubmit,
    ),
  ],);

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
      // If the keyboard is open, it will close and ruin the hero animation.
      // This workaround overrides the back button to close the keyboard, wait
      // a very small delay, *then* go back.
      // See: https://github.com/flutter/flutter/issues/86089
      leading: IconButton(
        icon: const Icon(Icons.arrow_back),
        onPressed: () async {
          FocusManager.instance.primaryFocus?.unfocus();
          await Future<void>.delayed(const Duration(milliseconds: 100));
          if (!context.mounted) return;
          context.pop();
        },
      ),
      actions: [
        if (!model.conversation.isSeller) TextButton(
          style: TextButton.styleFrom(foregroundColor: context.colorScheme.onPrimary),
          onPressed: model.openSellerProfile,
          child: const Text("View profile"),
        ),
      ],
      title: Row(
        children: [
          Hero(
            tag: "profile-pic-${model.conversation.id}",
            child: CircleFileImage(file: model.conversation.otherImageRef),
          ),
          const SizedBox(width: 12),
          Hero(
            tag: "name-${model.conversation.id}",
            child: Text(model.conversation.otherName),
          ),
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
          color: context.colorScheme.surface,
          child: Row(children: [
            Expanded(child: buildTextField(
              autofocus: true,
              focusNode: model.focusNode,
              controller: model.messageController,
              onSubmit: model.send,
              hint: "Type a message...",
              hasBorder: false,
            ),),
            if (!model.isScrolledToBottom) IconButton(
              icon: const Icon(Icons.arrow_downward),
              tooltip: "Scroll to bottom",
              onPressed: model.scrollToBottom,
            ),
          ],),
        ),
      ],
    ),
  );
}
