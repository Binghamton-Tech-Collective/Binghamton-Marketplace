import "package:firebase_auth/firebase_auth.dart";

import "service.dart";

/// Handles authentication for the app.
class AuthService extends Service {
  /// The Firebase Auth plugin.
  FirebaseAuth get firebase => FirebaseAuth.instance;

  @override
  Future<void> init() async { }

  @override
  Future<void> dispose() async { }

  /// Prompts the user to sign-in with a popup.
  /// 
  /// Returns null if the user dismisses the popup.
  Future<String?> signIn() async {
    final google = GoogleAuthProvider();
    final credential = await firebase.signInWithPopup(google);
    return credential.user?.uid;
  }

  /// Signs the user out of Firebase.
  /// 
  /// When calling [signIn] again, the user may not need to enter the credentials,
  /// and the process should happen automatically.
  Future<void> signOut() => firebase.signOut();

  /// The currently signed-in user.
  User? get user => firebase.currentUser;
}
