import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";
import "package:flutter_social_button/flutter_social_button.dart";

/// The products page.
class ProductPage extends ReactiveWidget<ProductViewModel>{
  final ProductID id;
  const ProductPage(this.id);
  
  @override
  ProductViewModel createModel() => ProductViewModel(id);

  @override
  Widget build(BuildContext context, ProductViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Item Details",
        style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
      ),
      backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
    ),
    body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            padding: const EdgeInsets.all(15),
            child: Row(
              children: [
                const CircleAvatar(
                  radius: 35,
                  backgroundImage: NetworkImage("https://media.licdn.com/dms/image/D4E03AQH1m-DsPxkXkQ/profile-displayphoto-shrink_800_800/0/1663694541598?e=2147483647&v=beta&t=jbiXqn5fY7dJUCgtYZ9a_KZrYWRmCHzg0YkJBdGoURg"),
                ),
                const SizedBox(width: 5),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text("Samuel Montes"),
                    Row(
                      children: [const Text("18 sales | ", style: TextStyle(fontSize: 10),),
                      RatingBarIndicator(
                        rating: 2.5,
                        itemSize: 10,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color: Colors.amber,
                            ),
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(width: 30),
                const SizedBox(
                    child: Column(
                      children: [
                        ElevatedButton(
                          onPressed: null,
                          child: Row(
                            children: [
                              Icon(Icons.message),
                              Text("Message"),
                            ],
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: null,
                              iconSize: 30,
                              disabledColor: Colors.black,
                              icon: Icon(Icons.facebook),
                            ),
                            IconButton(
                              onPressed: null,
                              iconSize: 20,
                              disabledColor: Colors.black,
                              icon: Icon(Icons.snapchat),
                            ),
                          ],
                        ),
                      ],
                    ),
                ),
              ],
            ),
          ),
          const Center(
            child: Padding(
              padding: EdgeInsets.all(15),
              child: SizedBox(
                width: 170,
                height: 130,
                child: Placeholder(),
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(15),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text("Item Name",style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 10),
                Text("Price of item:"),
                Text(r"$00.00",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                SizedBox(height: 8),
                Text("Condition:"),
                Text("Brand New", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Description:"),
                Text("Handmade Crochet Mini potted sunflower", style: TextStyle(fontWeight: FontWeight.bold)),
                SizedBox(height: 8),
                Text("Category:"),
                Chip(
                  label: Text("Clothing", style: TextStyle(color: Colors.white)),
                  backgroundColor: Colors.grey,
                  shape: StadiumBorder(),
                ),
              ],
            ),
          ), 
          ElevatedButton(
            onPressed: () {}, 
            child: const Text("Contact Seller"),
          ),
        ],
      ),
    );
}
