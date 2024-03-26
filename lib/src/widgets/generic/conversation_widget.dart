import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

/// Reusable widget for displaying conversations
class ConversationWidget extends StatelessWidget {
  /// The converstaion to be displayed in the list
  final Conversation conversation;

  /// Constructor of the ConversationWidget
  const ConversationWidget({required this.conversation, super.key});

  @override
  Widget build(BuildContext context) => ListTile(
        title: Text(conversation.otherName),
        // It's better to leave subtitle null if empty instead of ""
        // If it's an empty string, it pushes the title up higher when it doesn't need to
        subtitle: conversation.lastMessage == null
            ? null
            : Text(conversation.lastMessage!.content),
        leading: CircleAvatar(
          backgroundImage: NetworkImage(conversation.otherImage),
        ),
        // Assuming we add [Conversation.timestamp] or something
        trailing: Text(
          DateFormat("MM/dd/yyyy HH:mm")
              .format(conversation.lastMessage!.timeSent),
        ),
      );
}
