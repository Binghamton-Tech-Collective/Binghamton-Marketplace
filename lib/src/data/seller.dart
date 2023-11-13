import "review.dart";

class SellerProfile {
  final String id;
  final String imageUrl;
  final String bio;
  final ContactInfo contact;

  const SellerProfile({
    required this.id,
    required this.imageUrl,
    required this.bio,
    required this.contact,
  });

  int calculateAverageStars(List<Review> reviews) => 0;
}

class ContactInfo {
  final String email;
  final String? phoneNumber;
  final String? instaName, twitterName, linkedInName;

  const ContactInfo({
    required this.email,
    this.phoneNumber, 
    this.instaName,
    this.twitterName,
    this.linkedInName,
  });
}
