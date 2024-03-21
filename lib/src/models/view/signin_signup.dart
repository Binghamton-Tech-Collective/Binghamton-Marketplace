import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:flutter/material.dart";
// import "package:btc_market/services.dart";

/// This view model includes the logic required for the sign in and sign up view
class SignInSignUpViewModel extends ViewModel {
  late final bool signedIn;
  late final String username;

  TextEditingController usernameTextController =
      TextEditingController(); //try initial with google user name;
  @override
  Future<void> init() async {
    isLoading = true;
    signedIn = models.user.isSignedIn;
    isLoading = false;
  }

  ///Sets sign up username to text in usernameTextController
  void finalizeUsername() {
    username = usernameTextController.text.toLowerCase();
  }
}
