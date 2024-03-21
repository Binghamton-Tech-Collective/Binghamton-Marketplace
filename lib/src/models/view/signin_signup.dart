import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:flutter/material.dart";
// import "package:btc_market/services.dart";

/// This view model includes the logic required for the sign in and sign up view
class SignInSignUpViewModel extends ViewModel {
  late bool signedIn;
  late bool settingUsername;
  late String username;

  TextEditingController usernameTextController = TextEditingController();

  //TODO: Google auth portion and userTextController default text after that; should there be a state to get to username menu?

  @override
  Future<void> init() async {
    isLoading = true;
    signedIn = models.user.isSignedIn;
    settingUsername = false;
    isLoading = false;
  }

  ///Sets sign up username to text in usernameTextController if non-empty/whitespace and adds to database
  void finalizeUsername() {
    if (usernameTextController.text.trim() != "") {
      username = usernameTextController.text.toLowerCase().trim();
    }
  }

  ///After google sign in; check if they exit within our database
  bool doesUserExit() => true; //default

  /// Signs the user in and downloads their profile; implemented in user.dart; figure out how its relevant
  Future<void> signIn() async {} //once signed in --> go to default page

  ///Google sign up page --> fill text box with google username; should there also be a finalized button? (for the username I guess since sign up would add user to database)
  Future<void> signUp() async {
    //once signed up with google:
    settingUsername = true;
  }
}
