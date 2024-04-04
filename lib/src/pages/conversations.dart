import "package:flutter/material.dart";


import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/services.dart";

/// The page that displays all conversation for the user
class ConversationsPage extends ReactiveWidget<ConversationsViewModel> {
  @override
  ConversationsViewModel createModel() => ConversationsViewModel();

  @override
  Widget build(BuildContext context, ConversationsViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Chats"),
    ),
    body: model.allConversations.isNotEmpty
    ? ListView.builder(
      itemCount: model.allConversations.length,
      itemBuilder: (context, index) => ConversationWidget(
        conversation: model.allConversations[index],
      ),
    )
    : Center(
      child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Image.asset("categories/baxterInGreenhouse.jpg", width: 250, height: 200, fit: BoxFit.fill),
        const SizedBox(height: 16,),
        Container(
          padding: const EdgeInsets.all(16),
          child: const Text("Start of your conversation history!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),          
        ),
      ],
    ),
    ),
    );
}
