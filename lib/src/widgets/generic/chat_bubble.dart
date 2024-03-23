import "package:flutter/material.dart";

/// Reusable ChatBubble class for displaying texts
class ChatBubble extends StatelessWidget {
  /// Message to display
  final String message;

  /// Constructor of ChatBubble
  const ChatBubble({required this.message, super.key});

  @override
  Widget build(BuildContext context) => Container(
    padding: const EdgeInsets.all(12),
    decoration: BoxDecoration(
      borderRadius: BorderRadius.circular(8),
      color: const Color(0xFFDEDEDE),
    ),
    child: Text(
      message,
      style: const TextStyle(fontSize: 16),
    ),
  );
}
