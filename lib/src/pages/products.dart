//import "package:btc_market/main.dart";
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
    body: Center(child: model.isLoading
      ? const CircularProgressIndicator()
      : CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            collapsedHeight: 60,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 150,
                      color: const Color.fromARGB(255, 0, 65, 44),
                      alignment: const Alignment(0.75, 1),
                      child: Text(
                        "Home",
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
        ),
    ),
  );
}
