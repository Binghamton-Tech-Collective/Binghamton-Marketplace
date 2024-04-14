import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// A data model with app-wide settings.
class AppModel extends DataModel {
  ThemeMode _theme = ThemeMode.system;
  /// The current theme mode: light, dark, or system default.
  ThemeMode get theme => _theme;

  /// The last conversation with a notification, if any.
  Conversation? conversationNotification;

  /// Sets the theme for the app.
  void setTheme(ThemeMode value) {
    _theme = value;
    notifyListeners();
  }

  @override
  Future<void> onSignIn(UserProfile profile) async => setTheme(profile.theme);

  @override
  Future<void> onSignOut() async { }

  /// Updates [conversationNotification] with this conversation.
  void showMessage(Conversation conversation) {
    if (!conversation.showNotification) return;
    conversationNotification = conversation;
    notifyListeners();
  }
}

/// Useful methods on [ThemeMode]s.
extension ThemeModeUtils on ThemeMode {
  /// A human-friendly name for this option.
  String get displayName => switch (this) {
    ThemeMode.dark => "Dark",
    ThemeMode.light => "Light",
    ThemeMode.system => "System",
  };
}
