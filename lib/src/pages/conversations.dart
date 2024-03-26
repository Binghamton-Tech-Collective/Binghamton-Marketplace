import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// The page that displays all conversation for the user
class ConversationsPage extends ReactiveWidget<ConversationsViewModel> {
  @override
  ConversationsViewModel createModel() => ConversationsViewModel();

  @override
  Widget build(BuildContext context, ConversationsViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Chats"),
    ),
    body: ListView.builder(
      itemCount: model.allConversations.length,
      itemBuilder: (context, index) => ConversationWidget(
        conversation: model.allConversations[index],
      ),
    ),
  );
}
