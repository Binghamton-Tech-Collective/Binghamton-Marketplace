import "package:btc_market/pages.dart";
import "package:flutter/material.dart";

/// The call to action page to create a seller profile when there are none
class SellerProfileCallToAction extends StatelessWidget {
  /// Constructor for the page
  const SellerProfileCallToAction({super.key});

  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: const Text("Profile")),
    body: SizedBox(
      width: double.infinity,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          const Text("You don't have any seller profile! :(\n Click the button below to create one!",
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold,),),
          const SizedBox(height: 50,),
          ElevatedButton(onPressed: () => router.go("/sellers/create"),
           child: const Text("Create a Seller Profile"),),
        ],
      ),
    ),
  );
}
