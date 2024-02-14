import "package:flutter/material.dart";

import "package:btc_market/data.dart";

/// A widget to show off a product.
class ProductWidget extends StatelessWidget{
  /// The product being shown.
  final Product product;

  /// Creates a widget to show off this product.
  const ProductWidget(this.product);

  @override
  Widget build(BuildContext context) => const Card(child: Placeholder());
}
