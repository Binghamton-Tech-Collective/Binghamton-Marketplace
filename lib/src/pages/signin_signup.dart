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
            Image.network(
              "https://s3-alpha-sig.figma.com/img/dace/d7c0/2f582eea582281537c8401f7ddbdd70a?Expires=1711929600&Key-Pair-Id=APKAQ4GOSFWCVNEHN3O4&Signature=a8p5~pfkosSBKFlHPncIUkSyQgkaF0ZN4avj3J6eiAcDg4KMp1sk0Wrxn~-DaVjuQPNIkpnV0sifv2EhrdD4kgphbLLe3eWwmFuiwO2ULLWbPsFqJC1YY1fzHDUpQvPwqDAV4jYZXxJMcnHyY6vd2RTC6YyJAPogZfOAVE-XEJSxnM8q~wqP2RkUyWiI4AAalhVWYzc8WA8T7pDZxSxkFbXeUrP0XSuuModBd4j8KMZv8qQ7oWkidqvQT~T8IMvDLATXCIZ82nRf-o3vAnXS9BjlvA89AMSNAUKYj2wsOGvlRs6eHpr4BgB5ImYCDfkS-y1~P-Isqdeh92Ca1BcaDg__",
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
