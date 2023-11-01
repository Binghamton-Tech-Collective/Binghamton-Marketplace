import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// An example of a page that waits for its view model to load.
class ProfilePage extends ReactiveWidget<ProfileViewModel> {
  @override
  ProfileViewModel createModel() => ProfileViewModel();

  @override
  Widget build(BuildContext context, ProfileViewModel model) => Scaffold(
    body: model.isLoading 
      ? const Center(child: CircularProgressIndicator())
      : Text("Your name is ${model.name} and you have ${model.numLikes} likes"),
  );
}
