import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// The page to create or edit a seller profile.
class SellerProfileEditor extends ReactiveWidget<SellerProfileBuilder> {
  @override
  SellerProfileBuilder createModel() => SellerProfileBuilder();
  
  @override
  Widget build(BuildContext context, SellerProfileBuilder model) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
      title: const Text("Create Seller Profile",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
      ),
    ),
    // TODO: Check if you need a Center here
    body: Center(
      child: ListView(
        children: [
          const SizedBox(height: 20),
          const CircleAvatar(
            radius: 50,
            backgroundColor: Colors.grey,
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Name", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextField(
                  controller: model.nameController,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Who are you",
                  ),
                ),
              ],
            ),
          ),
          // TODO: Do we want major? 
          const Padding(
            padding: EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Major", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextField(
                  // controller: model.,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "What are you studying",
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Bio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextField(
                  controller: model.bioController,
                  keyboardType: TextInputType.multiline,
                  maxLines: null,
                  decoration: const InputDecoration(
                    border: OutlineInputBorder(),
                    hintText: "Tell us about yourself",
                  ),
                ),
              ],
            ),
          ), 
          // TODO: Move social media editors into their own file for reuse
          Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text("Instagram", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                TextField(
                  controller: model.instagramController,
                  decoration: const InputDecoration(
                    prefixText: "@",
                    //labelText: "@",
                    border: OutlineInputBorder(),
                    hintText: "username",
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20, bottom: 10, top: 20),
            child: ElevatedButton(
              // TODO: Check if we can get rid of this using standard themes
              style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(0, 90, 67, 1)),
              onPressed: model.isReady ? model.save : null,
              child: const Text("Submit", style: TextStyle(color: Colors.white)),
            ),                  
          ),
          Padding(
            padding: const EdgeInsets.only(left: 20, right: 20),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
              onPressed: () => context.pop(),
              child: const Text("Cancel", style: TextStyle(color: Colors.black)),
            ),
          ),
          if (model.errorText != null)
            Text(model.errorText!, style: const TextStyle(color: Colors.red)),
        ],
      ),
    ),
  );
}
