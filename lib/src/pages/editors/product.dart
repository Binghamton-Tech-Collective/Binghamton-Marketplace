import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";

/// The notifications page.
class ProductEditor extends ReactiveWidget<ProductBuilder> {
  @override
  ProductBuilder createModel() => ProductBuilder();

  @override
  Widget build(BuildContext context, ProductBuilder model) => Scaffold(
        body: Container(
          color: Colors.blue,
          height: 100,
          width: 500,
        ),
      );
}
