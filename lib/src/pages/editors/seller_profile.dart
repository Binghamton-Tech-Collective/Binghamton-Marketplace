import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The page to create or edit a seller profile.
class SellerProfileEditor extends ReactiveWidget<SellerProfileBuilder> {
  @override
  SellerProfileBuilder createModel() => SellerProfileBuilder();

  @override
  Widget build(BuildContext context, SellerProfileBuilder model) => Scaffold(
    appBar: AppBar(
      backgroundColor: context.colorScheme.primary,
      foregroundColor: context.colorScheme.onPrimary,
      title: const Text("Create Seller Profile"),
    ),
    body: ListView(
      padding: const EdgeInsets.all(24),
      children: [
        // ========== Basic info ==========
        ImageUploader(
          onTap: () => model.uploadImage(),
          imageUrl: model.imageUrl,
          onDelete: () => model.deleteImage(),
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
          prefixText: "@",
          hint: "username",
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
          height: 48,
          width: double.infinity,
          child: FilledButton(
            onPressed: model.isReady ? model.save : null,
            child: const Text("Create Profile"),
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
