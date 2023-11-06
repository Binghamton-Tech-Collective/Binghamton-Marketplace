import "package:btc_market/data.dart";
import "package:btc_market/services.dart";

import "../model.dart";

/// A data model to track the user and sign them in or out.
class UserModel extends DataModel {
  /// The currently signed-in user.
  User? user;

  @override
  Future<void> init() async { 
    // Try to automatically sign-in
  }

  /// Whether the user is signed in.
  bool get isSignedIn => user != null;

  /// Signs the user in with the given username and password, then updates [user].
  Future<void> signIn(String username, String password) async {
    // authenticate with Firebase Authentication
    user = await services.database.getUserProfile(username);
    notifyListeners();
  } 

  /// Signs the user out of their account.
  void signOut() {
    user = null;
    notifyListeners();
  }
}
