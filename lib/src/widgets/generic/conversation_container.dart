import "package:flutter/material.dart";

/// Reusable container for displaying Conversations
class ConversationContainer extends StatelessWidget {
  /// Image URL of the person we're having a conversation with
  final String imageURL;

  /// Name of the person we're having a conversation with
  final String name;

  /// Last Message of the person we're having a conversation with
  final String? lastMessage;

  /// Time of the last message with the person we're having a conversation with
  final String? time;

  /// Constructor for Conversation Container

  const ConversationContainer({
    required this.imageURL,
    required this.name,
    required this.lastMessage,
    required this.time,
  });

  @override
  Widget build(BuildContext context) => Container(
        padding: const EdgeInsets.all(12),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(imageURL),
              radius: 30,
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    name,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 18,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    lastMessage ?? "",
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(), // Pushes the time text to the extreme right
            Text(
              time ?? "",
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[500],
              ),
            ),
          ],
        ),
      );
}
