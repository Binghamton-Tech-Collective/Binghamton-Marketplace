import "review.dart";
import "types.dart";

/// Represents information about a seller.
///
/// Every user has a user profile and an associated User ID. If a user wants to sell on the app,
/// they can also create a seller profile with some basic information about themselves. Users can
/// then view these profiles as well as the products and reviews associated with them.
class SellerProfile {
  /// The seller's unique Seller ID.
  final SellerID id;

  /// The user's name.
  final String name;

  /// The User ID of this seller's owner.
  final UserID userID;

  /// The path to this seller's image.
  final String imagePath;

  /// The seller's biography or description.
  final String bio;

  /// The seller's contact information.
  final ContactInfo contact;

  /// Reviews of the Seller
  final List<Review> reviews;

  /// Creates a seller's profile.
  const SellerProfile({
    required this.id,
    required this.name,
    required this.userID,
    required this.imagePath,
    required this.bio,
    required this.contact,
    this.reviews = const [],
  });

  /// Calculates the average rating out of all the seller's reviews.
  // int calculateAverageRating(List<Review> reviews) => 0;
  double calculateAverageRating() {
    var sum = 0;
    for (final review in reviews) {
      sum += review.stars;
    }
    final average = sum / reviews.length;
    return average;
  }
}

/// Represents contact information for a seller.
class ContactInfo {
  /// The seller's email address.
  final String email;

  /// The seller's phone number, if provided.
  final String? phoneNumber;

  /// The seller's TikTok username, if provided.
  final String? tikTokUsername;

  /// The seller's Instagram handle, if provided.
  final String? instagramHandle;

  /// The seller's Twitter/X username, if provided.
  final String? twitterUsername;

  /// The seller's LinkedIn username, if provided.
  final String? linkedinUsername;

  /// Creates contact info for a seller.
  const ContactInfo({
    required this.email,
    this.phoneNumber,
    this.tikTokUsername,
    this.instagramHandle,
    this.twitterUsername,
    this.linkedinUsername,
  });
}
