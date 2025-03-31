import "package:btc_market/pages.dart";
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
    body: ListView(
      children: [
        if (!model.hasNotificationPermission) MaterialBanner(
          content: const ListTile(
            leading: Icon(Icons.notification_important),
            title: Text("Never miss a message"),
            subtitle: Text("Go to your settings to enable notifications"),
          ),
          actions: [
            TextButton(
              child: const Text("Go to settings"),
              onPressed: () => router.push(Routes.settings),
            ),
          ],
        ),
        SwitchListTile.adaptive(
          title: const Text("Show archived"),
          subtitle: model.showArchived
            ? const Text("Long press to unarchive")
            : const Text("Long press to archive"),
          secondary: const Icon(Icons.archive),
          value: model.showArchived,
          onChanged: model.updateShowArchive,
        ),
        if (model.isEmpty) ...[
          Image.asset("assets/bearcat/confused.png", width: 200, height: 200),
          const SizedBox(height: 16),
          const Text(
            "You don't have any conversations.\nStart one by clicking on a seller or a product!",
            style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
            textAlign: TextAlign.center,
          ),
        ],
        for (final conversation in model.conversations) ConversationWidget(
          conversation: conversation,
          onArchive: () => model.toggleArchive(conversation.id),
        ),
      ],
    ),
  );
}
