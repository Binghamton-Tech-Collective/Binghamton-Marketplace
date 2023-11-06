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
      children: [
        if (models.user.isSignedIn) Text(
          "Your name is ${model.name} and you have ${model.numLikes} likes",
          style: context.textTheme.headlineLarge,
        ),
        ElevatedButton(
          onPressed: () async { 
            await model.signIn();
          }, 
          child: const Text("Sign in with Google"),
        ),
      ],
    ),
  );
}
