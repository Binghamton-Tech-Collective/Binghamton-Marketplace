import "package:btc_market/data.dart";
import "package:btc_market/services.dart";

import "../model.dart";

class UserModel extends Model {
  User? user;

  @override
  void init() { /* Try to automatically sign-in */ }

  void signIn(String username, String password) {
    // authenticate with Firebase Authentication
    user = services.database.getUserProfile();
    notifyListeners();
  } 

  bool isSignedIn() => user != null;
}
