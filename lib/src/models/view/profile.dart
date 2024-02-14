import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// A view model for the profile page.
/// 
/// This is an example of a view model that does some initialization work. You'll notice that the
/// fields are "late", meaning they don't initialize to null but rather they don't initialize at
/// all. You are not allowed to access them until they are given a concrete, non-null value, so
/// we set [isLoading] to true to signal that the UI should load something else in the meantime.
class ProfileViewModel extends ViewModel {
  /// The profile of the currently signed-in user.
  late final UserProfile? profile;
  
  @override
  Future<void> init() async {
    isLoading = true;
    profile = models.user.userProfile;
    isLoading = false;
  }
}
