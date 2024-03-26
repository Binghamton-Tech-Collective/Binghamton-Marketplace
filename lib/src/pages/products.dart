import "package:btc_market/models.dart";
import "package:btc_market/src/widgets/generic/reactive_widget.dart";
import "package:flutter/material.dart";


/// The home page that lists all the products

class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  @override
  Widget build(BuildContext context, ProductsViewModel model) => const Scaffold(
        body: Text("This is the homepage!"),
      );
}
