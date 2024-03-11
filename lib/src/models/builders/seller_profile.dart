import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

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

  /// The seller's ID.
  late final SellerID sellerID;

  /// Fetching the email address of the seller
  String get email => services.auth.user!.email!;

  /// Fetching User ID of the seller
  late final UserID userID;

  /// URL of the profile image
  String? imageUrl;

  @override
  Future<void> init() async {
    isLoading = true;
    sellerID = services.database.sellers.newID;
    userID = models.user.userProfile!.id;
    isLoading = false;
  }

  /// Function to build the profile from the input provided by the user
  @override
  SellerProfile build() => SellerProfile(
    id: sellerID,
    name: nameController.text,
    userID: userID,
    imageUrl: imageUrl!,
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
    imageUrl != null &&
    email.isNotEmpty;

  /// Upload the image provided by the user and set the imageURL to the link obtained
  Future<void> uploadImage() async {
    final file = await services.cloudStorage.pickFile();
    if (file == null) return;
    final bytes = file.bytes!;
    final path = services.cloudStorage.getSellerProfilePath(sellerID);
    final url = await services.cloudStorage.uploadFile(bytes, path);
    if (url == null) {
      errorText = "Could not upload image";
      notifyListeners();
      return;
    }
    imageUrl = url;
    notifyListeners();
  }

  /// Saving the profile to Cloud Firestore
  Future<void> save() async {
    isLoading = true;
    final profile = build();
    await services.database.saveSellerProfile(profile);
    isLoading = false;
    notifyListeners();
  }
}
