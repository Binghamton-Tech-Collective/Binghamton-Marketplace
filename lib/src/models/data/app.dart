import "package:btc_market/models.dart";
import "package:flutter/material.dart";

/// A data model with app-wide settings.
class AppModel extends DataModel {
  final ThemeMode _theme = ThemeMode.system;
  /// The current theme mode: light, dark, or system default.
  ThemeMode get theme => _theme;
}
