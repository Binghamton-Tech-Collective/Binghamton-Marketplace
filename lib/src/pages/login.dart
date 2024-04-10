import "package:firebase_ui_oauth_google/firebase_ui_oauth_google.dart";
import "package:flutter/material.dart";
import "package:firebase_ui_auth/firebase_ui_auth.dart";

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
    Text("Welcome to the BTC marketplace", style: context.textTheme.headlineLarge),
    const SizedBox(height: 12),
    const SizedBox(height: 100, width: 200, child: Placeholder()),
    const SizedBox(height: 12),
    Expanded(
      child: SignInScreen(
        auth: services.auth.firebase,
        showAuthActionSwitch: false,
        providers: [GoogleProvider(clientId: googleID)],
        actions: [
          AuthStateChangeAction<UserCreated>((context, __) => model.onAuth()),
          AuthStateChangeAction<SignedIn>((context, state) => model.onAuth()),
        ],
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
      child: InputContainer(text: "Username", controller: model.usernameController),
    ),
    const SizedBox(height: 16),
    FilledButton(
      onPressed: model.isReady ? model.signUp : null, 
      child: const Text("Create account"),
    ),
  ];
}
