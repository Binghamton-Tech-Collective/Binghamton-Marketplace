import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

/// A view model for the profile page.
/// 
/// This is an example of a view model that does some initialization work. You'll notice that the
/// fields are "late", meaning they don't initialize to null but rather they don't initialize at
/// all. You are not allowed to access them until they are given a concrete, non-null value, so
/// we set [isLoading] to true to signal that the UI should load something else in the meantime.
class ProfileViewModel extends ViewModel {
  /// The currently-signed in user's profile.
  UserProfile? get profile => models.user.profile;
    
  @override
  Future<void> init() async { }

  /// Signs the user in and downloads their data. 
  Future<void> signIn() async {
    await models.user.signIn();
    notifyListeners();
  }

  /// Signs the user out of the app and refreshes the page.
  Future<void> signOut() async {
    await models.user.signOut();
    notifyListeners();
  }

  /// Adds one like to the user's like count.
  Future<void> incrementLikes() async {
    if (profile == null) return;
    profile!.numLikes++;
    await services.database.saveUserProfile(profile!);
    notifyListeners();
  }
}
