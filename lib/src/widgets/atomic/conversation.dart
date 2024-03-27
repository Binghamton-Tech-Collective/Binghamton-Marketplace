import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// A reusable widget for displaying conversations.
class ConversationWidget extends StatelessWidget {
  /// The conversation to display.
  final Conversation conversation;

  /// Constructor of the ConversationWidget
  const ConversationWidget({required this.conversation, super.key});

  @override
  Widget build(BuildContext context) => ListTile(
    title: Hero(
      tag: "name-${conversation.id}",
      child: Text(conversation.otherName),
    ),
    subtitle: conversation.lastMessage == null ? null
      : Text(conversation.lastMessage!.content),
    leading: Hero(
      tag: "profile-pic-${conversation.id}",
      child: CircleAvatar(
        backgroundImage: NetworkImage(conversation.otherImage),
      ),
    ),
    trailing: Text(context.formatDateAndTime(conversation.lastUpdate)),
    onTap: () => context.go("/messages/${conversation.id}", extra: conversation),
  );
}
