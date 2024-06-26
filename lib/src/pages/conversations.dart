import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The page that displays all conversation for the user
class ConversationsPage extends ReactiveWidget<ConversationsViewModel> {
  @override
  ConversationsViewModel createModel() => ConversationsViewModel();

  @override
  Widget build(BuildContext context, ConversationsViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Chats"),
      actions: [ProfileButton()],
    ),
    body: model.isEmpty
      ? Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/bearcat/confused.png", width: 200, height: 200),
            const SizedBox(height: 16),
            const Text(
              "You don't have any conversations.\nStart one by clicking on a seller or a product!",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      )
      : ListView(
        children: [
          SwitchListTile.adaptive(
            title: const Text("Show archived"),
            subtitle: model.showArchived
              ? const Text("Long press to unarchive")
              : const Text("Long press to archive"),
            secondary: const Icon(Icons.archive),
            value: model.showArchived, 
            onChanged: model.updateShowArchive,
          ),
          for (final conversation in model.conversations) ConversationWidget(
            conversation: conversation,
            onArchive: () => model.toggleArchive(conversation.id),
          ),
        ],
      ),
  );
}
