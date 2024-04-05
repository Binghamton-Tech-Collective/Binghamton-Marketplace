import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

class ConfirmDeleteModel extends ViewModel {
  final controller = TextEditingController();
  final SellerProfile profile;
  ConfirmDeleteModel(this.profile);
  
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
    await services.database.deleteSellerProfile(profile.id);
    await services.cloudStorage.deleteSellerProfile(profile.id);
    router.go("/");
  }
}

class ConfirmDeleteDialog extends ReactiveWidget<ConfirmDeleteModel> {
  final SellerProfile profile;
  const ConfirmDeleteDialog(this.profile);

  @override
  ConfirmDeleteModel createModel() => ConfirmDeleteModel(profile);

  @override
  Widget build(BuildContext context, ConfirmDeleteModel model) => AlertDialog(
    title: const Text("Confirm"),
    content: const Text("Are you sure you want to delete your profile? This is permanent and cannot be undone. This will also delete any products you have sold, and any ratings for those products."),
    actions: [
      TextButton(
        onPressed: () => Navigator.of(context).pop(),
        child: const Text("Cancel"),
      ),
      FilledButton(
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
