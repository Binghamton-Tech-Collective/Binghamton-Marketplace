import "package:btc_market/main.dart";
import "package:btc_market/src/models/view/products.dart";
//import "package:btc_market/src/pages/seller_profile.dart";
import "package:flutter/material.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// Products page
class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  /// Build
  @override
  Widget build(BuildContext context, ProductsViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text ("Home"),
      backgroundColor: darkGreen,
    ),

  );
}
