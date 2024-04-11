import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// A view model to confirm deletion of a [SellerProfile].
class ConfirmDeleteModel extends ViewModel {
  /// The text controller for the user to re-enter their name.
  final controller = TextEditingController();
  /// The profile being deleted.
  final SellerProfile profile;
  /// Creates a view model to delete a seller's profile.
  ConfirmDeleteModel(this.profile);
  
  /// Whether the user has confirmed they are ready to delete their profile.
  bool get isReady => controller.text.trim() == profile.name;

  @override
  Future<void> init() async {
    controller.addListener(notifyListeners);
  }

  @override
  void dispose() {
    controller.dispose();
    super.dispose();
  }

  /// A loading indicator while deleting the user's data.
  bool isDeleting = false;
  
  /// Deletes the user profile and all associated data. 
  /// 
  /// This action is permanent and cannot be undone.
  Future<void> deleteProfile() async {
    isDeleting = true;
    notifyListeners();
    await services.deleteSellerProfile(profile.id);
    await models.user.loadSellerProfiles();
    isDeleting = false;
    notifyListeners();
    router.pop();  // out of editor
    router.pop();  // out of seller page
    router.go("/sellers");  // back to safety
  }
}

/// A popup dialog to confirm if the user really wants to delete their [SellerProfile].
class ConfirmDeleteDialog extends ReactiveWidget<ConfirmDeleteModel> {
  /// The profile to delete.
  final SellerProfile profile;
  /// Creates a popup to confirm deletion of a seller's profile.
  const ConfirmDeleteDialog(this.profile);

  @override
  ConfirmDeleteModel createModel() => ConfirmDeleteModel(profile);

  @override
  Widget build(BuildContext context, ConfirmDeleteModel model) => AlertDialog(
    title: const Text("Confirm"),
    content: Column(
      mainAxisSize: MainAxisSize.min,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text("Are you sure you want to delete your profile? This will also delete:\n- Any products you have sold\n- Any ratings for those products."),
        const SizedBox(height: 8),
        Text(
          "This is a permanent action and cannot be undone. To confirm, enter your profile name below (${model.profile.name})",
          style: context.textTheme.labelLarge,
        ),
        const SizedBox(height: 8),
        TextField(
          controller: model.controller,
          decoration: InputDecoration(
            border: const OutlineInputBorder(),
            hintText: model.profile.name,
          ),
        ),
      ],
    ),
    actions: [
      if (model.isDeleting) const CircularProgressIndicator(),
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("Cancel"),
      ),
      FilledButton(
        style: FilledButton.styleFrom(backgroundColor: Colors.red),
        onPressed: !model.isReady ? null : () async {
          await model.deleteProfile();
          if (!context.mounted) return;
          Navigator.of(context).pop();
        }, 
        child: const Text("Delete"),
      ),
    ],
  );
}
