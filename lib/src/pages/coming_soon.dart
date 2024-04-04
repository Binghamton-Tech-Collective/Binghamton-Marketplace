import "package:flutter/material.dart";

/// Coming Soon page for features that are a part of next phase
class ComingSoonPage extends StatelessWidget {
  /// Constructor for page
  const ComingSoonPage({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Text("Coming Soon!!",
      style: TextStyle(
        color: Colors.white,
      ),),
    ),
    body: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        const Image(image: AssetImage("/bearcat/baxter.jpg",
        ),),
        const SizedBox(height: 16,),
        Container(
          padding: const EdgeInsets.all(16),
          child: const Text("Our squad's cooking up this page! It's gonna drop soon, stay tuned!",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, fontStyle: FontStyle.italic),),
        ),
      ],
    ),
  );
}
