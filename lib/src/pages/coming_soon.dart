import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// Coming Soon page for features that are a part of next phase
class ComingSoonPage extends StatelessWidget {
  /// Constructor for page
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Coming Soon!"),
      actions: [
        ProfileButton(),
      ],
    ),
    body: Center(child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Image(image: AssetImage("assets/bearcat/waiting.png",
        ),),
        const SizedBox(height: 16,),
        Container(
          padding: const EdgeInsets.all(16),
          child: const Text(
            "Our squad's cooking up this page!\n It's gonna drop soon, stay tuned!",
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),
          ),
        ),
      ],
    ),),
  );
}
