import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/src/widgets/generic/conversation_container.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

/// The page that diplays all conversation for the user
class ConversationsPage extends ReactiveWidget<ConversationsViewModel> {
  @override
  ConversationsViewModel createModel() => ConversationsViewModel();

  @override
  Widget build(BuildContext context, ConversationsViewModel model) => Scaffold(
        appBar: AppBar(
          backgroundColor: darkGreen,
          title: const Center(
            child: Text(
              "Chats",
              style: TextStyle(color: Colors.white),
              textAlign: TextAlign.center,
            ),
          ),
        ),
        body: ListView.builder(
          itemCount: model.allConversations.length,
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              final id = model.allConversations[index].id;
              return router.go("/messages/$id");
            },
            child: ConversationContainer(
              imageURL: model.allConversations[index].conversationImage,
              name: model.allConversations[index].conversationName,
              lastMessage: model.allConversations[index].lastMessage!.content,
              time: DateFormat("MM/dd/yyyy HH:mm").format(
                model.allConversations[index].lastMessage!.timeSent,
              ),
            ),
          ),
        ),
      );
}
