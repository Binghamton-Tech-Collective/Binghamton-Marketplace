import "package:btc_market/src/models/view/productPage.dart";
import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

class ProductPage extends ReactiveWidget<ProductPageViewModel>{
  @override
  ProductPageViewModel createModel() => ProductPageViewModel();

  @override
  Widget build(BuildContext context, ProductPageViewModel model) => Scaffold(
    body: Padding(
      padding: EdgeInsets.all(0.0),
      child: Container(
        color: Colors.blue,
        height: 100,
        width: 500,
      ),
    )
    
  );
}

