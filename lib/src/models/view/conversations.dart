import "dart:async";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:flutter/material.dart";
import "package:meta/meta.dart";

/// Extension type logics for the frontend code
extension ConversationsUtils on Conversation {
  /// To check if the user sending a message is a seller
  bool get isSeller => models.user.userProfile!.id == sellerUID;

  /// Getting the appropriate image based on the role
  String get otherImage => isSeller ? buyerImage : sellerImage;

  /// Getting the appropriate name based on the role
  String get otherName => isSeller ? buyerName : sellerName;

  /// Last message from the conversation
  String get lastMessage =>
      messages.isEmpty ? "" : messages[messages.length - 1].content;
}

/// The view model for loading list of all conversations for a user
class ConversationsViewModel extends ViewModel {
  /// The user profile of the user signed in
  final user = models.user.userProfile;

  /// List of all the conversations for the user
  late final List<Conversation> allConversations;

  @override
  Future<void> init() async {}
}
