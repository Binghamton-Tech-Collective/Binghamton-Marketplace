import "types.dart";

/// A conversation between a user and a seller
class Conversation {
    /// The IDs of the sellers/users involved
    List<String> members;
  /// The message history
  List<Message> messages;
  /// The product being discussed, if any
  final ProductID? product;

  /// A constructor to create a new Conversation.
  const Conversation({
    required this.members,
    this.messages = <Message>[],
    this.product = null,
  });

  /// Add a [Message] to the conversation (generally by sending a new one)
  void addMessage(Message message) => messages.add(message);

  /// Remove a [Message] from the conversation
  void remove(Message message) => messages.remove(message);
}
