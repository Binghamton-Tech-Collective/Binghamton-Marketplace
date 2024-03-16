import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:btc_market/pages.dart";

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

  /// All the text controllers used on the page.
  List<TextEditingController> get allControllers => [
        nameController,
        bioController,
        phoneNumberController,
        tikTokController,
        instagramController,
        twitterController,
        linkedinController,
      ];

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
    // TODO: Needs sign-in to work
    userID = models.user.userProfile!.id;
    for (final controller in allControllers) {
      controller.addListener(notifyListeners);
    }
    isLoading = false;
  }

  @override
  void dispose() {
    for (final controller in allControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  /// Function to build the profile from the input provided by the user
  @override
  SellerProfile build() => SellerProfile(
        id: sellerID,
        name: nameController.text,
        userID: userID,
        imageUrl: imageUrl ?? "https://picsum.photos/200",
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
      bioController.text.isNotEmpty
      // TODO: Needs image uploading in the UI
      &&
      imageUrl != null;

  /// Upload the image provided by the user and set the imageURL to the link obtained
  Future<void> uploadImage() async {
    final bytes = await services.cloudStorage.pickImage();
    if (bytes == null) return;
    final path = services.cloudStorage.getSellerImagePath(sellerID);
    final url = await services.cloudStorage.uploadFile(bytes, path);
    if (url == null) {
      errorText = "Could not upload image";
      notifyListeners();
      return;
    }
    imageUrl = url;
    notifyListeners();
  }

  /// Deletes the image at the given index.
  Future<void> deleteImage() async {
    imageUrl = null;
    final filename = services.cloudStorage.getSellerImagePath(sellerID);
    await services.cloudStorage.deleteFile(filename);
    notifyListeners();
  }

  /// Set the flag to true when we are saving the profile

  bool isSaving = false;

  /// Save the error, if any

  String? saveError;

  /// Saving the profile to Cloud Firestore
  Future<void> save() async {
    isSaving = true;
    saveError = null;
    final profile = build();
    try {
      await services.database.saveSellerProfile(profile);
      router.go("/");
    } catch (error) {
      saveError = "Error uploading profile:\n$error";
      rethrow;
    }
    isSaving = false;
    notifyListeners();
  }

  /// Cancelling the create profile
  void cancelProcess() {
    router.go("/");
  }

  //TODO: Add a validate method to check if the profile already exists
}
