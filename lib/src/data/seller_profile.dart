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
  final String imageUrl;

  /// The seller's biography or description.
  final String bio;

  /// The seller's contact information.
  final ContactInfo contact;

  /// Creates a seller's profile.
  const SellerProfile({
    required String email,
    required this.name,
    required this.userID,
    required this.imageUrl,
    required this.bio,
    required this.contact,
  }) : id = email;

  /// Creates a new SellerProfile object from a JSON object.
  SellerProfile.fromJson(Json json) : 
    id = json["id"],
    name = json["name"],
    userID = json["userID"],
    imageUrl = json["imageUrl"],
    bio = json["bio"],
    contact = ContactInfo.fromJson(json["contact"]);

  /// Convert this SellerProfile to its JSON representation
  Json toJson() => {
    "id": id,
    "name": name,
    "userID": userID,
    "imageUrl": imageUrl,
    "bio": bio,
    "contact": contact.toJson(),
  };
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
  final String? linkedInUsername;

  /// Creates contact info for a seller.
  const ContactInfo({
    required this.email,
    required this.phoneNumber, 
    required this.tikTokUsername,
    required this.instagramHandle,
    required this.twitterUsername,
    required this.linkedInUsername,
  });

  /// Creates a new ContactInfo object from a JSON object.
  ContactInfo.fromJson(Json json) : 
    email = json["email"],
    phoneNumber = json["phoneNumber"], 
    tikTokUsername = json["tikTokUsername"],
    instagramHandle = json["instagramHandle"],
    twitterUsername = json["twitterUsername"],
    linkedInUsername = json["linkedInUsername"];

  /// Convert this ContactInfo to its JSON representation
  Json toJson() => {
    "email": email,
    "phoneNumber": phoneNumber, 
    "tikTokUsername": tikTokUsername,
    "instagramHandle": instagramHandle,
    "twitterUsername": twitterUsername,
    "linkedInUsername": linkedInUsername,
  };
}
