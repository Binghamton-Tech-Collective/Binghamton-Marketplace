import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// A view model for the settings page.
class SettingsViewModel extends ViewModel {
  /// The user's theme preference.
  ThemeMode theme = ThemeMode.system;

  /// The currently signed-in user.
  UserProfile get profile => models.user.userProfile!;

  @override
  Future<void> init() async {
    theme = profile.theme;
    notifyListeners();
  }

  /// Updates [theme] and refreshes the UI.
  void updateTheme(ThemeMode? input) {
    if (input == null) return;
    theme = input;
    profile.theme = input;
    notifyListeners();
  }

  /// Saves the user's settings and updates the app theme.
  Future<void> save() async {
    await models.user.updateProfile(profile);
    models.app.setTheme(theme);
  }
}
