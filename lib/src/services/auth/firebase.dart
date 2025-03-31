import "package:firebase_auth/firebase_auth.dart";

import "package:btc_market/data.dart";
import "package:firebase_ui_auth/firebase_ui_auth.dart";
import "package:flutter/foundation.dart" show kIsWeb;

import "interface.dart";

/// The Google Cloud ID for Sign in with Google.
const googleID = "458210387235-239q08kt8uat1pvmor529ve2p9v4kea0.apps.googleusercontent.com";

/// Implements authentication using Firebase Auth.
class FirebaseAuthService extends Auth {
  /// The Firebase Auth plugin.
  late final FirebaseAuth firebase = FirebaseAuth.instance;

  @override
  Future<void> init() async { }

  @override
  Future<void> signOut() async {
    await firebase.signOut();
    await FirebaseUIAuth.signOut(auth: firebase);
  }

  @override
  Future<void> signIn() async {
    final google = GoogleAuthProvider().setCustomParameters({"hd": "binghamton.edu", "prompt": "select_account"});
    if (kIsWeb) {
      await firebase.signInWithPopup(google);
    } else {
      await firebase.signInWithProvider(google);
    }
  }

  /// The currently signed-in user.
  User? get _user => firebase.currentUser;

  @override
  String? get email => _user?.email;

  @override
  UserID? get userID => _user == null ? null : UserID(_user!.uid);
}
