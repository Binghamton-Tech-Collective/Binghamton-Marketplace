import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The products page.
class ProductPage extends ReactiveWidget<ProductViewModel>{
  @override
  ProductViewModel createModel() => ProductViewModel();

  @override
  Widget build(BuildContext context, ProductViewModel model) => Scaffold(
    body: Container(
      color: Colors.blue,
      height: 100,
      width: 500,
    ),
  );
}
