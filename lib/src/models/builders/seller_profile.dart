import "package:flutter/material.dart";

import "package:btc_market/data.dart";

import "../model.dart";

extension on String {
  String? get nullIfEmpty => isEmpty ? null : this;
}

class SellerProfileBuilder extends BuilderModel<SellerProfile> {
  final nameController = TextEditingController();
  final bioController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final tikTokController = TextEditingController();
  final instagramController = TextEditingController();
  final twitterController = TextEditingController();
  final linkedinController = TextEditingController();

  String get email => "";
  UserID get userID => "";
  String get imageUrl => "";  // <-- We need to discuss this
  SellerID get sellerID => "";

  @override
  SellerProfile get value => SellerProfile(
    id: sellerID,
    userID: userID,
    name: nameController.text,
    bio: bioController.text,
    imageUrl: imageUrl,
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
  bool get isReady => nameController.text.isNotEmpty
    // Check more conditions here. Be careful to only check what's required
    && bioController.text.isNotEmpty;

  Future<void> save() async {
    // ...
  }
}
