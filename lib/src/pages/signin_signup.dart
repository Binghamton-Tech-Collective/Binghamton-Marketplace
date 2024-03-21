import 'package:btc_market/src/models/view/signin_signup.dart';
import "package:flutter/material.dart";
import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";

/// The sign-in/sign-up page.
class SigninSignupPage extends ReactiveWidget<SignInSignUpViewModel> {
  @override
  SignInSignUpViewModel createModel() => SignInSignUpViewModel();

  @override
  Widget build(BuildContext context, SignInSignUpViewModel model) => Scaffold(
    body: Container(
      color: Colors.white,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Image
            Image.asset(
              "data:image/jpeg;base64,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",
              height: 150,
              width: 150,
            ),
            const SizedBox(height: 20),
            // Welcome text
            const Text(
              "Welcome to the BTC Marketplace",
              style: TextStyle(
                color: Colors.black,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 20),
            // Sign up with Google button
            ElevatedButton(
              onPressed: () {
                // Handle sign up with Google
              },
              child: const Text
              ("Sign up with Google"),
            ),
            const SizedBox(height: 20),
            // Have an account? Log in here text
            Text.rich(
              TextSpan(
                text: "Have an account?",
                style: TextStyle(
                  color: Colors.black.withOpacity(0.8),
                ),
                children: const [
                    TextSpan(
                    text: 'Log in',
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                    ),
                    // Add navigation to the login page
                    // Add your navigation logic here
                    // onTap: () {
                    //   Navigator.push(
                    //     context,
                    //     MaterialPageRoute(builder: (context) => LoginPage()),
                    //   );
                    // },
                  ),
                  TextSpan(text: ' here'),
                ],
              ),
            ),
          ],
        ),
      ),
    ),
  );
}
