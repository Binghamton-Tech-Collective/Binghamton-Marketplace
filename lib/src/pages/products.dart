import "package:btc_market/data.dart";
import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/src/widgets/atomic/product.dart";
import "package:btc_market/src/widgets/generic/reactive_widget.dart";
import "package:flutter/material.dart";

/// The home page that lists all the products

class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  @override
  Widget build(BuildContext context, ProductsViewModel model) {
    final productA = Product(
      id: "fsdf" as ProductID,
      sellerID: "asfsaf" as SellerID,
      userID: "asf" as UserID,
      title: "This is a very long and amazing title! Hopefully you like it!",
      description: "a new descriptions!!!",
      price: 165.80,
      quantity: 5,
      imageUrls: [
        "https://helios-i.mashable.com/imagery/reviews/03y8gbj1mqCuexgXxFJ5vyX/hero-image.fill.size_1248x702.v1623391330.jpg",
      ],
      categories: {Category.clothes},
      condition: ProductCondition.new_,
      dateListed: DateTime(
        2024,
      ),
    );
    final productB = Product(
      id: "fsdf" as ProductID,
      sellerID: "asfsaf" as SellerID,
      userID: "asf" as UserID,
      title: "This is a very long and amazing title! Hopefully you like it!",
      description: "a new descriptions!!!",
      price: 165.80,
      quantity: 5,
      imageUrls: [
        "https://helios-i.mashable.com/imagery/reviews/03y8gbj1mqCuexgXxFJ5vyX/hero-image.fill.size_1248x702.v1623391330.jpg",
      ],
      categories: {Category.clothes},
      condition: ProductCondition.new_,
      dateListed: DateTime(
        2024,
      ),
    );
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: const Center(
          child: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16),
            child: SearchBar(),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                ),
                child: const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Shop By Categories",
                    style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24,
                    ),
                  ),
                ),
              ),
              Container(
                margin: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                ),
                child: Row(
                  children: <Widget>[
                    CircularIconContainer(),
                    const SizedBox(
                      width: 25,
                    ),
                    CircularIconContainer(),
                    const SizedBox(
                      width: 25,
                    ),
                    CircularIconContainer(),
                    const SizedBox(
                      width: 25,
                    ),
                    CircularIconContainer(),
                    const SizedBox(
                      width: 25,
                    ),
                    CircularIconContainer(),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
              ),
              Column(
                children: <Widget>[
                  Container(
                    margin: const EdgeInsets.only(
                      left: 16,
                      right: 8,
                      bottom: 8,
                      top: 8,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        const Text(
                          "Free Items",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                            color: Colors.black,
                          ),
                        ),
                        Text(
                          "See All",
                          style: TextStyle(
                            fontSize: 12,
                            color: Colors.red[200],
                          ),
                        ),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(
                      left: 7,
                      right: 8,
                      bottom: 8,
                    ),
                    child: Row(
                      children: [
                        Expanded(child: ProductWidget(product: productA)),
                        Expanded(child: ProductWidget(product: productB)),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ],
      ),
    );
  }
}

/// SearchBar widget
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: darkGreen,
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: "Search here",
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            prefixIcon: GestureDetector(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            border: InputBorder.none, // Remove the default border
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      );
}

/// Resusable circular widget for showing categories
class CircularIconContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              "https://media.licdn.com/dms/image/D4E03AQH1m-DsPxkXkQ/profile-displayphoto-shrink_800_800/0/1663694541598?e=2147483647&v=beta&t=jbiXqn5fY7dJUCgtYZ9a_KZrYWRmCHzg0YkJBdGoURg",
            ),
          ),
          Text(
            "Textbooks",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
}
