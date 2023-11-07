import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";

class LoginPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Login")),
    body: Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(width: 200, height: 200, child: Placeholder()),
          SizedBox(height: 32),
          Text(
            "Welcome to the BTC Marketplace", 
            style: context.textTheme.displayMedium,
          ),
          SizedBox(height: 16),
          Text(
            "Please sign in below",
            style: context.textTheme.headlineLarge,
          ),
          SizedBox(height: 16),
          ElevatedButton(onPressed: () { }, child: Text("Sign in with Google")),
        ],
      )
    )
  );
}
