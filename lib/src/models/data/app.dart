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

extension ThemeModeUtils on ThemeMode {
  String get displayName => switch (this) {
    ThemeMode.dark => "Dark",
    ThemeMode.light => "Light",
    ThemeMode.system => "System",
  };
}
