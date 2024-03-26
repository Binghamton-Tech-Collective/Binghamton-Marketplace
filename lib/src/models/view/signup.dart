import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";
import "package:flutter/material.dart";
// import "package:btc_market/services.dart";

/// This view model includes the logic required for the sign in and sign up view
class SignUpViewModel extends BuilderModel<UserProfile> {
  bool showSignUp = false;
  late final UserID userID;
  String get username => usernameTextController.text;

  TextEditingController usernameTextController = TextEditingController();

  //TODO: Google auth portion and userTextController default text after that; should signout be an option here?; should there be a state to get to username menu?

  @override
  Future<void> init() async {
  }

  @override
  bool get isReady => username.isNotEmpty;

  UserProfile build() => UserProfile.newProfile(
    name: username.toLowerCase().trim(),
    id: userID,
  );

  ///After google sign in; check if they exit within our database
  Future<bool> doesUserExist() async {
    final user = await services.database.getUserProfile(userID);
    return user != null;
  }

  /// Signs the user in and downloads their profile; implemented in user.dart; figure out how its relevant
  Future<void> signIn() async {
    // 1. Sign in with Google and set the ID
    // 2. Check if we have an account using doesUserExist()
    // 3. If we do, call router.go("/products")
    // 4. If not, set showSignUp = true
    notifyListeners();
  }

  ///Google sign up page --> fill text box with google username; should there also be a finalized button? (for the username I guess since sign up would add user to database)
  Future<void> signUp() async {
    final profile = build();
    await services.database.saveUserProfile(profile);
    router.go("/products");
  }
}
