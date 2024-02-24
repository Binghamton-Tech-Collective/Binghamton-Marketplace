import "package:flutter/material.dart";

import "package:btc_market/data.dart";

import "../model.dart";

extension on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}

/// Class to create view model for sign up page for seller
class SellerProfileBuilder extends BuilderModel<SellerProfile> {
  /// Name of the seller
  final nameController = TextEditingController();

  /// Description of the seller
  final bioController = TextEditingController();

  /// Phone number of the seller
  final phoneNumberController = TextEditingController();

  /// Tiktok username of the seller
  final tikTokController = TextEditingController();

  /// Instagram username of the seller
  final instagramController = TextEditingController();

  /// Twitter username of the seller
  final twitterController = TextEditingController();

  /// Linkedin username of the seller
  final linkedinController = TextEditingController();

  /// Fetching the seller ID.
  SellerID get sellerID => "" as SellerID;

  /// Fetching the email address of the seller
  String get email => "";

  /// Fetching User ID of the seller
  UserID get userID => "" as UserID;

  /// URL of the profile image
  String get imageUrl => "";

  /// Function to build the profile from the input provided by the user
  @override
  SellerProfile build() => SellerProfile(
        id: sellerID,
        name: nameController.text,
        userID: userID,
        imageUrl: imageUrl,
        bio: bioController.text,
        contact: ContactInfo(
          email: email,
          phoneNumber: phoneNumberController.text.nullIfEmpty,
          tikTokUsername: tikTokController.text.nullIfEmpty,
          instagramHandle: instagramController.text.nullIfEmpty,
          twitterUsername: twitterController.text.nullIfEmpty,
          linkedInUsername: linkedinController.text.nullIfEmpty,
        ),
      );

  @override
  bool get isReady =>
      nameController.text.isNotEmpty &&
      bioController.text.isNotEmpty &&
      sellerID.toString().isNotEmpty &&
      userID.toString().isNotEmpty &&
      imageUrl.isNotEmpty &&
      hasValidEmail(email);

  @override
  Future<void> init() async {
    // Load the user's email and name here
  }

  /// Upload the image provided by the user and set the imageURL to the link obtained
  Future<void> uploadImage() async {
    // Pick a file, upload to Firebase Storage, then set [imageUrl]
  }

  /// Saving the profile to Cloud Firestore
  Future<void> save() async {
    // Save the result of build() to Cloud Firestore.
  }

  /// Checking if the format of the email is correct and has a binghamton.edu domain

  bool hasValidEmail(String email) {
    final emailRegex = RegExp(r"^[\w-\.]+@binghamton\.edu$");
    return emailRegex.hasMatch(email);
  }
}
