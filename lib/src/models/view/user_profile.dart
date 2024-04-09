import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";

/// This view model includes the logic required for the UserProfile view
class UserProfileViewModel extends ViewModel {
  
  ///The initially loaded profile, if any.
  final UserProfile? initialProfile;

  /// Whether the profile is loading or not
  bool isLoadingProfile = false;

  ///The profile variable will hold the object of the User Profile
  ///The profile will get the user profile infor from the model of the user profile
  late UserProfile profile;

  /// List of all of the seller profiles the user owns
  List<SellerProfile> get sellerProfiles => models.user.sellerProfiles;

  /// The seller ID to view
  UserID? id;

  /// Creates the profile view model
  UserProfileViewModel({
    required this.id,
    required this.initialProfile,
  });

  /// Getter for user profile image
  String? getImageURL() => null;

  /// Getter for user profile name
  String get name => profile.name;

  // Future implementation below

  
}
