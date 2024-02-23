import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

/// The products page.
class ProductPage extends ReactiveWidget<ProductViewModel>{
  /// ID of product
  final ProductID id;
  /// const constructor
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
    body: model.isLoading 
      ? const Center(child: CircularProgressIndicator())
      : model.errorText != null 
        ? Center(child: Text(model.errorText!))
        : ListView(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.all(5),
                child: Wrap(
                    children: [
                      for(final image in model.product.imageUrls)
                        SizedBox(
                          width: double.infinity,
                          height: 200,
                          child: Image.network(image),
                        )
                    ],
                  ),
              ),
            ),
            Padding(
              padding: EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(model.product.title,style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                      Spacer(),
                      Text("Condition: "),
                      Text("Brand New", style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
                    ],
                  ),
                 Row(
                  children: [
                    Text("\$${model.product.price}",style: TextStyle(fontWeight: FontWeight.bold, fontSize: 24)),
                    const Spacer(),
                    if (model.averageRating != null) RatingBarIndicator(
                      rating: model.averageRating as double, 
                      itemSize: 20,
                      itemBuilder: (context, _) => const Icon(
                        Icons.star,
                        color: Colors.amber,
                      ),
                    ),
                  ],
                 ),
                  SizedBox(height: 5),
                  Text("Description:"),
                  Text(model.product.description, style: TextStyle(fontWeight: FontWeight.bold)),
                  SizedBox(height: 8),
                  Text("Category:"),
                  Wrap(children: [
                    for (final category in model.product.categories) ...[
                      Chip(
                      label: Text(category.title, style: TextStyle(color: Colors.white)),
                      backgroundColor: Colors.grey,
                      shape: StadiumBorder(),
                    ),  
                    const SizedBox(width: 5),
                    ],
                  ],),
                ],
              ),
            ), 
            Container(
              padding: const EdgeInsets.all(15),
              child: Row(
                children: [
                  CircleAvatar(
                    radius: 20,
                    backgroundImage: NetworkImage(model.sellerProfile.imageUrl),
                  ),
                  const SizedBox(width: 5),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                       Text("${model.sellerProfile.name}"),
                      Row(
                        children: [ RatingBarIndicator(
                          rating: 2.5,
                          itemSize: 15,
                          itemBuilder: (context, _) => const Icon(
                                Icons.star,
                                color: Colors.amber,
                              ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  const Spacer(),
                  const IconButton(
                    onPressed: null,
                    iconSize: 30,
                    disabledColor: Colors.black,
                    icon: Icon(Icons.facebook),
                  ),
                  IconButton(
                    onPressed: () {},
                    iconSize: 20,
                    disabledColor: Colors.black,
                    icon: const Icon(Icons.snapchat_outlined),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child:
                ElevatedButton(
                onPressed: () {}, 
                style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(0, 90, 67, 1)),
                child: const Text("Contact Seller", style: TextStyle(color: Colors.white)),
                ),
            ),
          ],
        ),
      );
}
