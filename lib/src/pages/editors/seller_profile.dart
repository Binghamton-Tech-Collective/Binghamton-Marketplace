import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:btc_market/data.dart";

import "confirm_delete.dart";

/// The page to create or edit a seller profile.
class SellerProfileEditor extends ReactiveWidget<SellerProfileBuilder> {
  /// Id to edit the Seller Profile
  final SellerID? id;

  /// The already-loaded profile to edit, if one is not being created.
  final SellerProfile? profile;

  /// Constructor to initialize the seller id
  const SellerProfileEditor({this.id, this.profile});

  @override
  SellerProfileBuilder createModel() => SellerProfileBuilder(
    initialID: id,
    profile: profile,
  );

  @override
  Widget build(BuildContext context, SellerProfileBuilder model) => Scaffold(
    appBar: AppBar(
      title: model.isEditing
        ? const Text("Edit profile")
        : const Text("Create Seller Profile"),
    ),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // ========== Basic info ==========
        Hero(
          tag: "${model.sellerID}-image",
          placeholderBuilder: (_, __, ___) => const PlaceholderImageUploader(),
          child: ImageUploader(
            onTap: () => model.uploadImage(),
            imageUrl: model.imageUrl,
            onDelete: () => model.deleteImage(),
          ),
        ),
        if (model.imageError != null) Text(
          model.imageError!,
          style: TextStyle(color: context.colorScheme.error),
        ),
        const SizedBox(height: 12),
        InputContainer(
          text: "Name", 
          hint: "Your name will be visible to others", 
          controller: model.nameController,
        ),
        InputContainer(
          text: "Bio", 
          hint: "Tell us about yourself", 
          controller: model.bioController,
        ),

        // ========== Social media ==========
        InputContainer(
          text: "Instagram", 
          controller: model.instagramController,
          prefixText: "@",
          hint: "username",
        ),
        InputContainer(
          text: "LinkedIn", 
          controller: model.linkedinController,
          hint: "profile url",
        ),
        InputContainer(
          text: "TikTok", 
          controller: model.tikTokController,
          prefixText: "@",
          hint: "username",
        ),
        InputContainer(
          text: "Twitter / X", 
          controller: model.twitterController,
          prefixText: "@",
          hint: "username",
        ),

        // ========== Confirmation and loading indicators ==========
        const SizedBox(height: 12),
        SizedBox(
          // height: 48,
          child: Row(
            children: [
              if (model.isEditing) Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                    backgroundColor: Colors.red,
                  ),
                  onPressed: () => showDialog<void>(
                    context: context,
                    builder: (context) => ConfirmDeleteDialog(model.profile!),
                  ),
                  child: const Text("Delete Profile"),
                ),
              ),
              if (model.isEditing) const SizedBox(width: 12),
              Expanded(
                child: FilledButton(
                  style: FilledButton.styleFrom(
                    padding: const EdgeInsets.symmetric(vertical: 16),
                  ),
                  onPressed: model.isReady ? model.save : null,
                  child: const Text("Save Profile"),
                ),
              ),
            ],
          ),
        ),
        if (model.saveError != null)
          Text(
            model.saveError!,
            style: TextStyle(color: context.colorScheme.error),
          ),
        if (model.isSaving) const LinearProgressIndicator(),
        if (model.errorText != null) Text(
          model.errorText!,
          style: const TextStyle(color: Colors.red),
        ),
      ],
    ),
  );
}
