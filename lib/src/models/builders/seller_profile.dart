import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:btc_market/pages.dart";

/// Class to create view model for sign up page for seller
class SellerProfileBuilder extends BuilderModel<SellerProfile> {
  /// Id of the seller to be edited
  final SellerID? initialID;
  
  /// Constructor to initialize the SellerID
  SellerProfileBuilder({this.initialID, this.profile});

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

  /// Seller Profile of the seller
  SellerProfile? profile;

  /// Whether this page is editing a profile that already exists.
  bool get isEditing => initialID != null;

  @override
  Future<void> init() async {
    if (initialID == null) { 
      sellerID = services.database.sellers.newID;
    } else {
      if (profile == null) {
        isLoading = true;
        profile = await services.database.getSellerProfile(initialID!);
        isLoading = false;
      }
      if (!profile!.isUser) {
        errorText = "You can't edit someone else's profile!";
        return;
      }
      final seller = profile!;
      profile = seller;
      sellerID = seller.id;
      imageUrl = seller.imageUrl;
      nameController.text = seller.name;
      bioController.text = seller.bio;
      phoneNumberController.text = seller.contact.phoneNumber != null ? seller.contact.phoneNumber! : "";
      tikTokController.text = seller.contact.tikTokUsername != null ? seller.contact.tikTokUsername! : "";
      instagramController.text = seller.contact.instagramHandle != null ? seller.contact.instagramHandle! : "";
      twitterController.text = seller.contact.twitterUsername != null ? seller.contact.twitterUsername! : "";
      linkedinController.text = seller.contact.linkedInUsername != null ? seller.contact.linkedInUsername! : "";
    }
    userID = models.user.userID!;
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

  @override
  SellerProfile build() => SellerProfile(
    id: sellerID,
    name: nameController.text.trim(),
    userID: userID,
    imageUrl: imageUrl!,
    bio: bioController.text.trim(),
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
    nameController.text.isNotEmpty
    && bioController.text.isNotEmpty
    && imageUrl != null;

  /// The error when uploading or downloading the image, if any.
  String? imageError;
  
  /// Upload the image provided by the user and set the imageURL to the link obtained
  Future<void> uploadImage() async {
    final bytes = await services.cloudStorage.pickImage();
    if (bytes == null) return;
    final path = services.cloudStorage.getSellerImagePath(sellerID);
    final url = await services.cloudStorage.uploadFile(bytes, path);
    if (url == null) {
      imageError = "Could not upload image";
      notifyListeners();
      return;
    }
    imageUrl = url;
    notifyListeners();
  }

  /// Deletes the image at the given index.
  Future<void> deleteImage() async {
    if (imageUrl == null) return;
    await services.cloudStorage.deleteFile(imageUrl!);
    imageUrl = null;
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
    try {
      final result = build();
      await models.user.addSellerProfile(result);
      if (isEditing) {
        router.pop(result);
      } else {
        router.pushReplacement("/sellers/${result.id}").ignore();
      }
    } catch (error) {
      saveError = "Error creating profile:\n$error";
      rethrow;
    }
    isSaving = false;
    notifyListeners();
  }
}
