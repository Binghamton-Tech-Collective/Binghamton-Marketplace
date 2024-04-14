import "package:flutter/material.dart";
import "package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart";

import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";
import "package:btc_market/widgets.dart";

/// A page to sign the user in, create an account, and redirect to another route.
class LoginPage extends ReactiveWidget<LoginViewModel> {
  /// The route to redirect to after sign-in or sign-up, if any.
  final String? redirect;
  /// Creates the login page.
  const LoginPage({this.redirect});
  
  @override
  LoginViewModel createModel() => LoginViewModel(redirect: redirect ?? Routes.products);

  @override
  Widget build(BuildContext context, LoginViewModel model) => Scaffold(
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (model.showSignUp) ..._signUp(context, model) 
          else ..._signIn(context, model),
        ],
      ),
    ),
  );

  List<Widget> _signIn(BuildContext context, LoginViewModel model) => [
    const Spacer(),
    Text("ShopBing", style: context.textTheme.headlineMedium),
    const SizedBox(height: 8),
    Image.asset("assets/logos/btc.png", height: 200, width: 350),
    Text("Your one-stop shop for buying and selling at Binghamton University", style: context.textTheme.titleSmall, textAlign: TextAlign.center),
    const SizedBox(height: 24),
    SizedBox(
      width: 300, 
      child: GoogleSignInButton(
        loadingIndicator: const CircularProgressIndicator(),
        overrideDefaultTapAction: true,
        onTap: model.onAuth, 
        clientId: googleID,
        label: "Sign in with Google",
      ),
    ),
    const SizedBox(height: 12),
    if (model.isSaving) const CircularProgressIndicator(),
    if (model.error != null) Text(model.error!, style: const TextStyle(color: Colors.red)),
    const Spacer(),
  ];

  List<Widget> _signUp(BuildContext context, LoginViewModel model) => [
    Text("Create an account", style: context.textTheme.headlineLarge),
    const SizedBox(height: 16),
    SizedBox(
      width: 200,
      height: 200,
      child: ImageUploader(
        imageUrl: model.imageUrl, 
        onDelete: model.deleteImage, 
        onTap: model.pickImage,
      ),
    ),
    const SizedBox(height: 16),
    SizedBox(
      width: 200, 
      child: InputContainer(text: "Name", controller: model.usernameController),
    ),
    const SizedBox(height: 16),
    FilledButton(
      onPressed: model.isReady ? model.signUp : null, 
      child: const Text("Create account"),
    ),
  ];
}
