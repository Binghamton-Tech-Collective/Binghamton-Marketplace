import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";
import "package:flutter/widgets.dart";

//Seller Page class
class CreateSellerPage extends ReactiveWidget<SellerProfileViewModel>{
  @override
  SellerProfileViewModel createModel() => SellerProfileViewModel();

  ///Name 
  TextEditingController name = TextEditingController();
  ///Major
  TextEditingController major = TextEditingController();
  ///bio
  TextEditingController bio = TextEditingController();
  ///ig
  TextEditingController ig = TextEditingController();
  @override
  Widget build(BuildContext context, SellerProfileViewModel model) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
      title: const Text("Create Seller Profile",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
      ),
    ),
    body: Center(
      child: Column(
        children: [
          Expanded(child: ListView(
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
                        controller: name,
                        decoration: const InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Who are you",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Major", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: major,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "What are you studying",
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Bio", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: bio,
                        keyboardType: TextInputType.multiline,
                        maxLines: null,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(),
                          hintText: "Tell us about yourself",
                        ),
                      ),
                    ],
                  ),
                ), 
                Padding(
                  padding: EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Instagram", style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                      TextField(
                        controller: ig,
                        decoration: InputDecoration(
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
                  child: 
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(0, 90, 67, 1)),
                      onPressed: () {
                        debugPrint(name.text);
                        debugPrint(major.text);
                        debugPrint(bio.text);
                        debugPrint(ig.text);
                        name.clear();
                        major.clear();
                        bio.clear();
                        ig.clear();
                      }, 
                      child: const Text("Submit", style: TextStyle(color: Colors.white)),),                  
                ),
               Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20),
                  child: 
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(backgroundColor: Colors.grey),
                      onPressed: () {
                        name.clear();
                        major.clear();
                        bio.clear();
                        ig.clear();
                      }, 
                      child: const Text("Cancel", style: TextStyle(color: Colors.black)),),                  
                ),   
              ],
          ),),
        ],
      ),
    ),
  );
}
