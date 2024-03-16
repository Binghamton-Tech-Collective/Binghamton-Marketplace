import "package:btc_market/data.dart";
import "package:btc_market/services.dart";

import "../model.dart";

/// A data model to track the user and sign them in or out.
class UserModel extends DataModel {
  /// The currently signed-in user.
  UserProfile? userProfile;

  /// The seller profile owned by this user, if any.
  late final List<SellerProfile> sellerProfiles;

  @override
  Future<void> init() async {
    // Try to automatically sign-in
    await signIn();
  }

  /// Whether the user is signed in.
  bool get isSignedIn => userProfile != null;

  /// Signs the user in and downloads their profile.
  Future<void> signIn() async {
    final uid = await services.auth.signIn();
    if (uid == null) return;
    userProfile = await services.database.getUserProfile(uid as UserID);
    if (userProfile == null) {
      // create and save a new user profile
      userProfile = UserProfile.newProfile(
        name: services.auth.user!.displayName!,
        id: services.auth.user!.uid as UserID,
      );
      await services.database.saveUserProfile(userProfile!);
    }
    // [!] By this point we definitely have a userProfile because of the above null check
    sellerProfiles = await services.database.getSellerProfilesForUser(userProfile!.id);
    notifyListeners();
  }

  /// Signs the user out of their account.
  Future<void> signOut() async {
    await services.auth.signOut();
    userProfile = null;
    notifyListeners();
  }
}
