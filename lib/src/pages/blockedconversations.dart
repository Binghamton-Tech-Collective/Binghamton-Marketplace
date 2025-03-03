import "package:flutter/material.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The page that displays all blocked conversations for the user
class BlockedConversationsPage extends ReactiveWidget<ConversationsViewModel> {
  @override
  ConversationsViewModel createModel() => ConversationsViewModel();

  @override
  Widget build(BuildContext context, ConversationsViewModel model) => Scaffold(
        appBar: AppBar(
          title: const Text("Blocked Conversations"),
          actions: [ProfileButton()],
        ),
        body: model.blockedConversations.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      "assets/bearcat/confused.png",
                      width: 200,
                      height: 200,
                    ),
                    const SizedBox(height: 16),
                    const Text(
                      "You don't have any blocked conversations.",
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        fontStyle: FontStyle.italic,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              )
            : ListView.builder(
                itemCount: model.blockedConversations.length,
                itemBuilder: (context, index) {
                  final conversation = model.blockedConversations[index];
                  return ListTile(
                    title: Text(conversation.otherName),
                    subtitle: const Text("Blocked Conversation"),
                    trailing: ElevatedButton(
                      onPressed: () {
                        model.unblockConversation(conversation.id);
                      },
                      child: const Text("Unblock"),
                    ),
                  );
                },
              ),
      );
}
