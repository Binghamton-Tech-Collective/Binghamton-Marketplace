import "package:flutter/material.dart";
import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/widgets.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";


/// The profile page.
class SellerProfilePage extends ReactiveWidget<SellerProfileViewModel> {
  /// The ID of the seller to view.
  final SellerID id;
  /// Creates the Seller Profile page. 
  const SellerProfilePage(this.id);
  
  @override
  SellerProfileViewModel createModel() => SellerProfileViewModel(id);

  @override
  Widget build(BuildContext context, SellerProfileViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Profile",
        style: TextStyle(color: Colors.white),
      ),
      backgroundColor: const Color.fromARGB(255, 0, 65, 44),
    ),
    body: ListView(
      children: [
        Row(
          children: [
            Padding(
              padding: const EdgeInsets.all(15),
              child: CircleAvatar(
              backgroundImage: NetworkImage(model.profile.imageUrl),
              radius: 50,
              ),
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(model.profile.name,
                  style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Row(
                      children: [RatingBarIndicator(
                        rating: 5, 
                        itemSize: 20,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      const Text(" | 10 Sales "),
                    ],
                  ),
                  Text(model.profile.bio,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                   Row(
                    children: [
                      IconButton(
                        onPressed: () { },
                        iconSize: 20,
                        icon: const Icon(Icons.facebook),
                      ),
                      IconButton(
                        onPressed: () { },
                        iconSize: 20,
                        icon: const Icon(Icons.snapchat),
                      ),
                      IconButton(
                        onPressed: () { },
                        iconSize: 20,
                        icon: const Icon(Icons.message),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      const Divider(
        indent: 20,
        endIndent: 20,
        color: Colors.grey,
        thickness: 3,
      ),
      const Padding(
        padding: EdgeInsets.only(left: 15),
        child: Text("Seller Categories",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
        ),
      ),
      Container(
        padding: const EdgeInsets.only(left: 15, right: 15),
        child: SizedBox(
          height: 110,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              for (final category in model.categories) Column(
                mainAxisAlignment: MainAxisAlignment.end,
                children:  [
                  const Padding(
                    padding: EdgeInsets.only(left: 10, right: 10),
                    child: CircleAvatar(backgroundColor: Colors.red , radius: 40)),
                  Text(category.title),
                ],
              ),
            ],
          ),
        ), 
      ), 
      const Divider(
        indent: 20,
        endIndent: 20,
        thickness: 3,
        color: Colors.grey,
      ),
    const Padding(
      padding: EdgeInsets.only(left: 15),
      child: Text(
        "Listings",
        style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
      ),
    ),
    Container(
      padding: const EdgeInsets.all(15),
      height: 200,
      child: ListView(
          scrollDirection: Axis.horizontal,
          children: [
            for(final product in model.productList)
              SizedBox(
                width: 200,
                child:  ProductWidget(product: product),
            ), 
          ],
        ),
      ),
      ],
    )
  );
}
