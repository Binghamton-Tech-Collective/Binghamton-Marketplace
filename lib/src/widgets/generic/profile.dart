import "package:btc_market/models.dart";
import "package:flutter/material.dart";

/// The profile button that offers an option to sign out.
class ProfileButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MenuAnchor(
    builder: (context, controller, child) => IconButton(
      icon: CircleAvatar(
        backgroundImage: NetworkImage(models.user.userProfile!.imageUrl),
      ),
      onPressed: () => controller.isOpen ? controller.close() : controller.open(),
      tooltip: "Profile",
    ),
    menuChildren: [
      ListTile(
        title: Text(models.user.userProfile!.name),
      ),
      const Divider(),
      MenuItemButton(
        onPressed: models.user.signOut,
        child: const Text("Sign out"), 
      ),
    ],
  );
}
