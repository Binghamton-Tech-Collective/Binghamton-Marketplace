import "package:btc_market/data.dart";
import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
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
  Widget build(BuildContext context, ConversationViewModel model) => Scaffold(
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
          Text(model.conversation.otherName),
        ],
      ),
    ),
    body: Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemCount: model
                .messages.length, // Replace with actual number of messages
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
                      decoration: BoxDecoration(
                        border: Border.all(),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Text(model.messages[index].content),
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
          // color: Colors.grey[200],
          child: Row(
            children: [
              Expanded(
                child: TextField(
                  controller: model.messageController,
                  onSubmitted: (input) => model.addMessage(),
                  decoration: const InputDecoration(
                    hintText: "Type a message...",
                    border: InputBorder.none,
                  ),
                ),
              ),
              IconButton(
                icon: const Icon(Icons.send),
                onPressed: () {
                  model.addMessage();
                },
              ),
            ],
          ),
        ),
      ],
    ),
  );
}
