import "package:btc_market/models.dart";
import "package:flutter/material.dart";

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
