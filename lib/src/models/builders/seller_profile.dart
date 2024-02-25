import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:flutter/material.dart";
import "package:btc_market/data.dart";
import "../model.dart";

extension on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}

/// Class to create view model for sign up page for seller
class SellerProfileBuilder extends BuilderModel<SellerProfile> {
  /// Fetching the User from the model
  final user = models.user;

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
  late final SellerID sellerID;
  // SellerID get sellerID => "" as SellerID;

  late final String email;

  /// Fetching the email address of the seller
  // String get email => user.userProfile;

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
      email.isNotEmpty;

  @override
  Future<void> init() async {
    // Load the user's email and name here
    sellerID = services.database.sellers.newID;
  }

  /// Upload the image provided by the user and set the imageURL to the link obtained
  Future<void> uploadImage() async {
    // Pick a file, upload to Firebase Storage, then set [imageUrl]
    /**
     * Package: file_picker => This function should be called here
     * The functions will be in cloud_storage.dart and will be asynchronous
     * Have a look at PlatformFile datatype
     */
  }

  /// Saving the profile to Cloud Firestore
  Future<void> save() async {
    // Save the result of build() to Cloud Firestore.
  }
}
