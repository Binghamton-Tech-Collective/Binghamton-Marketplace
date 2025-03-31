import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";

/// A data model to track the user and sign them in or out.
class UserModel extends DataModel {
  /// The currently signed-in user.
  UserProfile? userProfile;

  /// The user ID of the currently signed-in user, if any.
  UserID? get userID => userProfile?.id;

  /// The seller profile owned by this user, if any.
  List<SellerProfile> sellerProfiles = [];

  @override
  Future<void> init() async {
    // Try to automatically sign-in
    await signIn();
    // If the user grants notification access using the browser or OS settings,
    // then the user's FCM token will never have been set in the database.
    // So we check here if we're signed in, have permission, but no FCM token.
    if (isSignedIn) {
      final hasPermission = await services.notifications.hasPermission();
      if (hasPermission && !userProfile!.hasNotificationsEnabled) {
        await updateNotificationsToken();
      }
    }
  }

  /// Whether the user is signed in.
  bool get isSignedIn => userProfile != null;

  /// Whether this user is a seller.
  bool get isSeller => sellerProfiles.isNotEmpty;

  /// Signs the user in and downloads their profile.
  Future<void> signIn() async {
    final uid = services.auth.userID;
    if (uid == null) return;
    final profile = await services.database.getUserProfile(uid);
    if (profile == null) return;
    await models.onSignIn(profile);
  }

  /// Asks the user for permission to send push notifications, and saves their unique token.
  ///
  /// Chrome will automatically reject this permission unless it's requested in response to a
  /// button press, so this method should *not* be called automatically.
  Future<void> updateNotificationsToken() async {
    await services.notifications.requestPermission();
    userProfile!.token = services.notifications.firebaseToken;
    await updateProfile(models.user.userProfile!);
  }

  @override
  Future<void> onSignIn(UserProfile profile) async {
    userProfile = profile;
    sellerProfiles = await services.database.getSellerProfilesForUser(profile.id);
    notifyListeners();
  }

  /// Signs the user out of their account.
  Future<void> signOut() async {
    await services.auth.signOut();
    sellerProfiles = [];
    userProfile = null;
    notifyListeners();
    await models.onSignOut();
    router.go("/login");
  }

  @override
  Future<void> onSignOut() async { }

  /// Updates the user's profile.
  Future<void> updateProfile(UserProfile profile) async {
    await services.database.saveUserProfile(profile);
    userProfile = profile;
    notifyListeners();
  }

  /// Adds a seller profile to the database and remembers it.
  Future<void> addSellerProfile(SellerProfile profile) async {
    await services.database.saveSellerProfile(profile);
    sellerProfiles.add(profile);
    notifyListeners();
  }

  /// Deletes a seller profile from the database and forgets it.
  Future<void> deleteSellerProfile(SellerProfile profile) async {
    await services.deleteSellerProfile(profile.id);
    sellerProfiles.remove(profile);
  }
}
