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
  /// The User ID of this seller's owner.
  final UserID userID;
  /// The path to this seller's image.
  String imagePath;
  /// The seller's biography or description.
  final String bio;
  /// The seller's contact information.
  final ContactInfo contact;

  /// Creates a seller's profile.
  const SellerProfile({
    required this.id,
    required this.userID,
    required this.imagePath,
    required this.bio,
    required this.contact,
  });

  /// Calculates the average rating out of all the seller's reviews.
  int calculateAverageRating(List<Review> reviews) { 
      var rating = 0;
      for (const review in review) {
          rating += review.stars;
      }

      return rating ~/ reviews.length;
}

/// Represents contact information for a seller.
class ContactInfo {
  /// The seller's email address.
  String email;
  /// The seller's phone number, if provided.
  String? phoneNumber;
  /// The seller's TikTok username, if provided.
  String? tikTokUsername;
  /// The seller's Instagram handle, if provided.
  String? instagramHandle;
  /// The seller's Twitter/X username, if provided. 
  String? twitterUsername;
  /// The seller's LinkedIn username, if provided.
  String? linkedInUsername;

  /// Creates contact info for a seller.
  const ContactInfo({
    required this.email,
    this.phoneNumber, 
    this.tikTokUsername,
    this.instagramHandle,
    this.twitterUsername,
    this.linkedInUsername,
  });
}
