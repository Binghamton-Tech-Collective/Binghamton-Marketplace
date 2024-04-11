import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// This view model includes the logic required for the UserProfile view
class UserProfileViewModel extends ViewModel {
  ///The initially loaded profile, if any.
  UserProfile get profile => models.user.userProfile!;

  /// Whether the profile is loading or not
  bool isLoadingProfile = false;

  /// List of all of the seller profiles the user owns
  List<SellerProfile> get sellerProfiles => models.user.sellerProfiles;

  /// Getter for user profile image
  String? getImageURL() => null;

  /// Getter for user profile name
  String get name => profile.name;  
}
