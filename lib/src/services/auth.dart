import "package:firebase_auth/firebase_auth.dart";

import "package:btc_market/data.dart";

import "service.dart";

/// The Google Cloud ID for Sign in with Google.
const googleID = "458210387235-239q08kt8uat1pvmor529ve2p9v4kea0.apps.googleusercontent.com";

/// Handles authentication for the app.
class AuthService extends Service {
  /// The Firebase Auth plugin.
  late final FirebaseAuth firebase = FirebaseAuth.instance;

  @override
  Future<void> init() async { }

  @override
  Future<void> dispose() async { }

  /// Signs the user out of Firebase.
  Future<void> signOut() async {
    await firebase.signOut();
  }

  /// The currently signed-in user.
  User? get user => firebase.currentUser;

  /// Gets the [UserID] of the currently signed-in user.
  UserID? get userID => user == null ? null : UserID(user!.uid);
}
