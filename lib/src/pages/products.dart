import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/src/widgets/generic/reactive_widget.dart";
import "package:flutter/material.dart";

/// The home page that lists all the products

class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  @override
  Widget build(BuildContext context, ProductsViewModel model) {
    final productName =
        "${"A new name which is so long that itksdfjsadk sduhfksad".substring(0, 10)}...";

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
            padding: const EdgeInsets.all(16),
            child: SearchBar(),
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
