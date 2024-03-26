import "package:btc_market/data.dart";
import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/src/widgets/generic/chat_bubble.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// The Chat Page for Conversations
class ConversationPage extends ReactiveWidget<ConversationViewModel> {
  /// Unique ID for the conversation
  final ConversationID id;

  /// Constructor
  const ConversationPage(this.id);

  @override
  ConversationViewModel createModel() => ConversationViewModel(id);

  @override
  Widget build(BuildContext context, ConversationViewModel model) {
    WidgetsBinding.instance.addPostFrameCallback(
      (_) {
        model.scrollToBottom();
        model.messageFocusNode.requestFocus();
      },
    );

    void showPopupMenu(BuildContext context, Offset position, int index) {
      final overlay =
          Overlay.of(context).context.findRenderObject()! as RenderBox;
      final popupPosition = RelativeRect.fromRect(
        Rect.fromPoints(position, position),
        Offset.zero & overlay.size,
      );

      showMenu(
        context: context,
        position: popupPosition,
        items: const <PopupMenuEntry<String>>[
          PopupMenuItem(
            value: "edit",
            child: Text("Edit"),
          ),
          PopupMenuItem(
            value: "unsend",
            child: Text("Unsend"),
          ),
        ],
      ).then<void>((dynamic value) {
        if (value == null) return;
        if (value == "edit") {
          model.isEditing = true;
          model.editingIndex = index;
          model.messageController.text =
              model.conversation.messages[index].content;
        } else if (value == "unsend") {
          model.deleteMessage(index);
        }
      });
    }

    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Hero(
              tag: "profile-pic",
              child: CircleAvatar(
                radius: 20,
                backgroundImage: NetworkImage(model.conversation.otherImage),
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Text(
              model.conversation.otherName,
              style: const TextStyle(color: Colors.white),
            ),
          ],
        ),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: ListView.builder(
              controller: model.scrollController,
              itemCount: model.messages.length,
              itemBuilder: (context, index) => Row(
                children: [
                  if (model.messages[index].isAuthor)
                    const SizedBox(
                      width: 36,
                    ),
                  Flexible(
                    child: Align(
                      alignment: model.messages[index].isAuthor
                          ? Alignment.centerRight
                          : Alignment.centerLeft,
                      child: Container(
                        margin: const EdgeInsets.all(8),
                        padding: const EdgeInsets.all(8),
                        child: GestureDetector(
                          onLongPressStart: (details) {
                            if (model.messages[index].isAuthor) {
                              showPopupMenu(
                                context,
                                details.globalPosition,
                                index,
                              );
                            }
                          },
                          child: Column(
                            crossAxisAlignment: model.messages[index].isAuthor
                                ? CrossAxisAlignment.end
                                : CrossAxisAlignment.start,
                            children: <Widget>[
                              ChatBubble(
                                message: model.messages[index].content,
                              ),
                              Text(
                                context.formatDateAndTime(model.conversation.messages[index].timeSent),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (!model.messages[index].isAuthor)
                    const SizedBox(
                      width: 36,
                    ),
                ],
              ),
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    focusNode: model.messageFocusNode,
                    controller: model.messageController,
                    onSubmitted: (input) {
                      if (!model.isEditing) {
                        model.addMessage();
                      } else {
                        model.editMessage(model.editingIndex);
                        model.isEditing = false;
                      }
                    },
                    decoration: const InputDecoration(
                      hintText: "Type a message...",
                      border: InputBorder.none,
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.send),
                  onPressed: () {
                    if (model.messageController.text.trim().isNotEmpty) {
                      if (!model.isEditing) {
                        model.addMessage();
                      } else {
                        model.editMessage(model.editingIndex);
                        model.isEditing = false;
                      }
                    }
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
