import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// Reusable chat bubble for [Message]s.
class ChatBubble extends StatelessWidget {
  /// The message to display.
  final Message message;
  /// A function to call when the user chooses to edit this message.
  final VoidCallback onEdit;
  /// A function to call when the user chooses to delete this message.
  final VoidCallback onDelete;

  /// Shows the given chat [Message] as a chat bubble.
  const ChatBubble({
    required this.message, 
    required this.onEdit,
    required this.onDelete,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Container(
    alignment: message.isAuthor
      ? Alignment.centerRight
      : Alignment.centerLeft,
    padding: const EdgeInsets.all(12),
    child: Column(
      crossAxisAlignment: message.isAuthor
        ? CrossAxisAlignment.end
        : CrossAxisAlignment.start,
      children: [
        MenuAnchor(
          menuChildren: [
            MenuItemButton(
              onPressed: onEdit,
              child: const Text("Edit"),
            ),
            MenuItemButton(
              onPressed: onDelete,
              child: const Text("Unsend"),
            ),
          ],
          builder: (context, controller, child) => InkWell(
            borderRadius: BorderRadius.circular(8),
            onLongPress: message.isAuthor ? controller.open : null,
            onSecondaryTap: message.isAuthor ? controller.open : null,
            child: Ink(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: message.isAuthor 
                  ? context.colorScheme.primaryContainer
                  : context.colorScheme.secondary,
              ),
              child: Text(
                message.content,                
                style: context.textTheme.bodyLarge?.copyWith(
                  color: message.isAuthor 
                    ? context.colorScheme.onPrimaryContainer
                    : context.colorScheme.onSecondary,
                ),
              ),
            ),
          ),
        ),
        // The timeEdited will not be null since it will run only after the null check
        Text(message.timeEdited != null ? "${context.formatDateAndTime(message.timeEdited!)} edited" : context.formatDateAndTime(message.timeSent)),
      ],),
  );
}
