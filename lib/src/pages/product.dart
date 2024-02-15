import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The products page.
class ProductPage extends ReactiveWidget<ProductViewModel>{
  final ProductID id;
  const ProductPage(this.id);
  
  @override
  ProductViewModel createModel() => ProductViewModel(id);

  @override
  Widget build(BuildContext context, ProductViewModel model) => Scaffold(
    body: Placeholder(),
  );
}
