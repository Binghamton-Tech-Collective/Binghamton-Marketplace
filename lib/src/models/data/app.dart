import "package:btc_market/models.dart";
import "package:flutter/material.dart";

class AppModel extends DataModel {
  ThemeMode _theme = ThemeMode.system;
  ThemeMode get theme => _theme;

  void toggle() {
    _theme = _theme == ThemeMode.dark ? ThemeMode.light : ThemeMode.dark;
    notifyListeners();
  }
}
