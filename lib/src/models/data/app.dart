import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/widgets.dart";

/// A data model with app-wide settings.
class AppModel extends DataModel {
  ThemeMode _theme = ThemeMode.system;
  /// The current theme mode: light, dark, or system default.
  ThemeMode get theme => _theme;

  /// Sets the theme for the app.
  void setTheme(ThemeMode value) {
    _theme = value;
    notifyListeners();
  }

  @override
  Future<void> onSignIn(UserProfile profile) async => setTheme(profile.theme);

  @override
  Future<void> onSignOut() async { }

  /// A hook into the UI, to call [ScaffoldMessenger.of] with.
  BuildContext? context;

  /// Sends an in-app notification about this conversation via a [MaterialBanner].
  void showMessage(Conversation conversation) {
    if (context == null || !conversation.showNotification) return;
    ScaffoldMessenger.of(context!).showMaterialBanner(
      MaterialBanner(
        content: ListTile(
          onTap: () {
            ScaffoldMessenger.of(context!).hideCurrentMaterialBanner();
            router.go("${Routes.messages}/${conversation.id}");
          },
          title: Text("New message from ${conversation.otherName}"),
          subtitle: Text(conversation.summary ?? "Tap to see details"),
          leading: CircleFileImage(file: conversation.otherImageRef),
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => ScaffoldMessenger.of(context!).hideCurrentMaterialBanner(),
          ),
          TextButton(
            child: const Text("Reply"),
            onPressed: () {
              ScaffoldMessenger.of(context!).hideCurrentMaterialBanner();
              router.go("${Routes.messages}/${conversation.id}");
            },
          ),
        ],
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.only(left: 16, top: 16),
        elevation: 8,
      ),
    );
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
