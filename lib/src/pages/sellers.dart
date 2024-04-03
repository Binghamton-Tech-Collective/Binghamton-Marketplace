import "package:btc_market/src/models/view/sellers.dart";
import "package:btc_market/src/widgets/atomic/sellers.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// The page that displays all conversation for the user
class SellersPage extends ReactiveWidget<SellersViewModel> {
  @override
  SellersViewModel createModel() => SellersViewModel();

  @override
  Widget build(BuildContext context, SellersViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Sellers"),
      actions: [
        IconButton(
          icon: const Icon(Icons.refresh),
          onPressed: model.init,
          tooltip: "Refresh",
        ),
      ],
    ),
    body: RefreshIndicator.adaptive(
      onRefresh: model.init,
      child: ListView.builder(
        itemCount: model.allSellers.length,
        itemBuilder: (context, index) => SellerWidget(
          seller: model.allSellers[index],
        ),
      ),
    ),
  );
}
