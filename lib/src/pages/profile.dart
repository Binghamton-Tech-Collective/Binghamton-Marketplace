import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// An example of a page that waits for its view model to load.
class ProfilePage extends ReactiveWidget<ProfileViewModel> {
  @override
  ProfileViewModel createModel() => ProfileViewModel();

  @override
  Widget build(BuildContext context, ProfileViewModel model) => Scaffold(
    body: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (models.user.isSignedIn) ElevatedButton(
          onPressed: model.signOut,
          child: const Text("Sign out"),
        ) else ElevatedButton(
          onPressed: model.signIn,
          child: const Text("Sign in with Google"),
        ),
        if (models.user.isSignedIn) Text(
          // We use ! because we *know* that [model.profile] is non-null because we checked [isSignedIn]
          "Your name is ${model.profile!.name} and you have ${model.profile!.numLikes} likes",
          style: context.textTheme.headlineLarge,
        ),
      ],
    ),
    floatingActionButton: models.user.isSignedIn ? FloatingActionButton(
      onPressed: model.incrementLikes,
      child: const Icon(Icons.add),
    ) : null,
  );
}
