import "package:btc_market/data.dart";
import "package:btc_market/services.dart";

import "../model.dart";

/// A data model to track the user and sign them in or out.
class UserModel extends DataModel {
  /// The currently signed-in user.
  UserProfile? profile;

  @override
  Future<void> init() async { 
    // Try to automatically sign-in
  }

  /// Whether the user is signed in.
  bool get isSignedIn => profile != null;

  /// Signs the user in and downloads their profile.
  Future<void> signIn() async {
    final uid = await services.auth.signIn();
    if (uid == null) return;
    profile = await services.database.getUserProfile(uid);
    if (profile == null) {  // create and save a new user profile
      profile = UserProfile(
        name: services.auth.user!.displayName!,
        userId: services.auth.user!.uid,
        numLikes: 0,
      );
      await services.database.saveUserProfile(profile!);
    }
    notifyListeners();
  }

  /// Signs the user out of their account.
  Future<void> signOut() async {
    await services.auth.signOut();
    profile = null;
    notifyListeners();
  }
}
