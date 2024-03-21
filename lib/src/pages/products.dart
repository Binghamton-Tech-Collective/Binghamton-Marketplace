import "package:btc_market/src/data/notification.dart";
import "package:btc_market/src/pages/notifications.dart";
import "package:btc_market/src/pages/profile.dart";
import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();


  @override
  Widget build(BuildContext context, ProductsViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text ('Home'),
      backgroundColor: Color(#005A43),
    )
      
  );
}
