import "package:btc_market/models.dart";

/// A view model for the login page.
class LoginViewModel extends ViewModel {
  /// The username entered in the UI.
  String username = "";
  /// The password entered in the UI.
  String password = "";
  
  @override
  Future<void> init() async { }

  /// Signs the user in and returns whether it succeeded.
  Future<bool> signIn() async {
    isLoading = true;
    notifyListeners();
    models.user.signIn(username, password);
    isLoading = false;
    notifyListeners();
    return models.user.isSignedIn;
  }
}
