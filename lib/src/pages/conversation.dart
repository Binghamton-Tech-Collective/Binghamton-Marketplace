import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// The Chat Page for Conversations
class ConversationPage extends ReactiveWidget<ConversationViewModel> {
  /// Unique ID for the conversation
  final ConversationID id;

  /// Constructor
  const ConversationPage(this.id);

  @override
  ConversationViewModel createModel() => ConversationViewModel(id);

  @override
  Widget build(BuildContext context, ConversationViewModel model) =>
    const Scaffold(
      body: Placeholder(),
    );
}
