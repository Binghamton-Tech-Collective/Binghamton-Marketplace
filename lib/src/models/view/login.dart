import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";
import "package:flutter/material.dart";

/// A test account that is allowed to be used, even if it doesn't end in @binghamton.edu
const testAccount = "harshvaghani98@gmail.com";

/// A view model to sign the user in, show a sign-up form if needed, then redirect to another route.
class LoginViewModel extends BuilderModel<UserProfile> {
  /// Whether to show the signup form.
  bool showSignUp;

  /// The user ID, if the user is signed in.
  UserID? get userID => services.auth.userID;

  /// The text controller for the username text field.
  final usernameController = TextEditingController();

  /// The username entered in the text field, if any.
  String? get username => usernameController.text.trim().nullIfEmpty;

  /// The image uploaded, if any.
  String? imageUrl;

  /// The error when saving, if any.
  String? error;

  /// Whether the account is being saved.
  bool isSaving = false;

  /// The user's theme preference.
  ThemeMode theme = ThemeMode.system;

  /// The route to redirect to after a successful sign in or registration.
  final String redirect;

  /// The profile to edit, if any.
  UserProfile? initialProfile;

  /// Creates a view model to sign in or register then go to the redirect URL.
  LoginViewModel({required this.redirect, required this.showSignUp});

  @override
  Future<void> init() async {
    usernameController.addListener(notifyListeners);
    final profile = models.user.userProfile;
    if (profile != null) {
      initialProfile = profile;
      imageUrl = profile.imageUrl;
      usernameController.text = profile.name;
      theme = profile.theme;
    }
  }

  @override
  void dispose() {
    usernameController.dispose();
    super.dispose();
  }

  @override
  bool get isReady => userID != null
    && username != null
    && imageUrl != null
    && !isSaving;

  @override
  UserProfile build() => UserProfile(
    name: username!,
    id: userID!,
    imageUrl: imageUrl!,
    archivedConversations: initialProfile?.archivedConversations ?? {},
    productsWatchlist: initialProfile?.productsWatchlist ?? {},
    sellersWatchlist: initialProfile?.sellersWatchlist ?? {},
    theme: theme,
  );

  /// Once the user is signed in, checks their profile and sets [showSignUp], if needed.
  Future<void> onAuth() async {
    error = null;
    notifyListeners();
    await services.auth.signIn();
    await models.user.signIn();
    final email = services.auth.email;
    if (email == null) return;
    if (!email.endsWith("binghamton.edu") && email != testAccount) {
      error = "Please sign in with your Binghamton email";
      notifyListeners();
      await services.auth.signOut();
      return;
    }
    if (models.user.isSignedIn) {
      await services.notifications.requestPermission();
      router.go(redirect);
      return;
    } else {
      final userID = services.auth.userID;
      if (userID == null) return;
      showSignUp = true;
    }
    notifyListeners();
  }

  /// Creates a [UserProfile] using the provided image and username.
  Future<void> signUp() async {
    final profile = build();
    isSaving = true;
    notifyListeners();
    await models.user.updateProfile(profile);
    isSaving = false;
    notifyListeners();
    router.go(redirect);
  }

  /// Deletes the image from Firebase Cloud Storage.
  Future<void> deleteImage() async {
    if (imageUrl == null) return;
    await services.files.deleteFile(imageUrl!);
    imageUrl = null;
    notifyListeners();
  }

  /// Picks an image and uploads it to Firebase Cloud Storage.
  Future<void> pickImage() async {
    if (userID == null) return;
    final file = await services.files.pickImage();
    isSaving = true;
    error = null;
    notifyListeners();
    if (file == null) return;
    final filename = services.files.getUserImagePath(userID!);
    final url = await services.files.uploadFile(file, filename);
    if (url == null) error = "Could not upload image";
    imageUrl = url;
    isSaving = false;
    notifyListeners();
  }

  /// Updates [theme] and refreshes the UI.
  void updateTheme(ThemeMode? input) {
    if (input == null) return;
    theme = input;
    models.app.setTheme(input);
    notifyListeners();
  }
}
