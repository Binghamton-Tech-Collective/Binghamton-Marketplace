import "package:btc_market/pages.dart";
import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The profile button that offers an option to sign out.
class ProfileButton extends ReusableReactiveWidget<UserModel> {
  /// Creates a button that listens to changes in the user's profile.
  ProfileButton() : super(models.user);

  @override
  Widget build(BuildContext context, UserModel model) => MenuAnchor(
    builder: (context, controller, child) => IconButton(
      icon: !model.isSignedIn ? const Icon(Icons.help): CircleBtcImage(
        image: NetworkImage(model.userProfile!.imageUrl),
      ),
      onPressed: () => controller.isOpen ? controller.close() : controller.open(),
      tooltip: "Profile",
    ),
    menuChildren: [
      MenuItemButton(
        onPressed: () => router.push(Routes.settings),
        child: const Text("Settings"),
      ),
      MenuItemButton(
        onPressed: models.user.signOut,
        child: const Text("Sign out"),
      ),
    ],
  );
}
