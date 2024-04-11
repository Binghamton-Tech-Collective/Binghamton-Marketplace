import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The user's profile page.
class UserProfilePage extends ReactiveWidget<UserProfileViewModel>{
  /// A const constructor.
  const UserProfilePage();

  @override
  UserProfileViewModel createModel() => UserProfileViewModel();

  @override
  Widget build(BuildContext context, UserProfileViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Profile"),
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (model.isLoadingProfile) const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()))
        else Row(
          children: [
            CircleAvatar(
              backgroundImage: NetworkImage(model.profile.imageUrl),
              radius: 50,
            ),
            const SizedBox(width: 16),
            Text("Sam", style: context.textTheme.headlineLarge),
          ],
        ),
        const SizedBox(height: 10),
        const Divider(),
        Text("Manage Profiles", style: context.textTheme.headlineMedium),
        DropdownMenu(
          label: const Text("Profile"),
          dropdownMenuEntries: [
            for (final sellerProfile in model.sellerProfiles) DropdownMenuEntry(
              value: sellerProfile,
              label: sellerProfile.name,
              leadingIcon: CircleAvatar(backgroundImage: NetworkImage(sellerProfile.imageUrl)),
            ),
          ],
        ),
        const Divider(),
        Text("Notifications", style: context.textTheme.headlineMedium),
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/bearcat/confused.png", width: 200, height: 200),
            const SizedBox(height: 16),
            const Text(
              "You don't have any notifications.",
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ],
    ),
  );
}
