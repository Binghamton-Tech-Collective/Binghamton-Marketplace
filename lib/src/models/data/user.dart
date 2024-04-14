import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";

/// A data model to track the user and sign them in or out.
class UserModel extends DataModel {
  /// The currently signed-in user.
  UserProfile? userProfile;

  /// The seller profile owned by this user, if any.
  List<SellerProfile> sellerProfiles = [];

  @override
  Future<void> init() async {
    // Try to automatically sign-in
    await signIn();
  }

  /// Whether the user is signed in.
  bool get isSignedIn => userProfile != null;

  /// Whether this user is a seller.
  bool get isSeller => sellerProfiles.isNotEmpty;

  /// Signs the user in and downloads their profile.
  Future<void> signIn() async {
    final uid = services.auth.userID;
    if (uid == null) return;
    userProfile = await services.database.getUserProfile(uid);
    await loadSellerProfiles();
    if (userProfile == null) return;
    models.app.setTheme(userProfile!.theme);
  }

  /// Loads the user's seller profiles.
  Future<void> loadSellerProfiles() async {
    if (userProfile == null) return;
    sellerProfiles = await services.database.getSellerProfilesForUser(userProfile!.id);
    notifyListeners();
  }

  /// Signs the user out of their account.
  Future<void> signOut() async {
    await services.auth.signOut();
    sellerProfiles = [];
    userProfile = null;
    notifyListeners();
    router.go("/login");
  }

  /// Updates the user's profile.
  Future<void> updateProfile(UserProfile profile) async {
    await services.database.saveUserProfile(profile);
    userProfile = profile;
    notifyListeners();
  }
}
