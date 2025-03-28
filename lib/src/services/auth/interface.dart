import "package:btc_market/data.dart";

import "../service.dart";

/// Handles authentication for the app.
abstract class Auth extends Service {
  /// Signs the user in using their Google Account.
  Future<void> signIn();

  /// Signs the user out of Firebase.
  Future<void> signOut();

  /// The currently signed-in user's [UserID].
  UserID? get userID;

  /// The currently signed-in user's email.
  String? get email;
}
