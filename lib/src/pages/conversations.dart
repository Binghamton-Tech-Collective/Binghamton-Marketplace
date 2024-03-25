import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/src/widgets/generic/chat_bubble.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";
import "package:intl/intl.dart";

class ConversationsPage extends ReactiveWidget<ConversationsViewModel> {
  @override
  ConversationsViewModel createModel() => ConversationsViewModel();
}
