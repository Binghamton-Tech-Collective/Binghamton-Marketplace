import "package:flutter/material.dart";

import "package:btc_market/data.dart";

/// A widget to show off a product.
class ProductWidget extends StatelessWidget{
  // final Product product;
  const ProductWidget();
  @override
  Widget build(BuildContext context) => Column(
    crossAxisAlignment: CrossAxisAlignment.start ,
    children: [
      Card(
        clipBehavior: Clip.none,
        child: InkWell(
          splashColor: Colors.blue.withAlpha(30),
          onTap: () {
            debugPrint("Card Tapped");
          },
          child: const SizedBox(
            width: 170,
            height: 130,
            child: Placeholder(),
          ),
        ),
      ),
      const Text(r"$00.00 product name",
        style: TextStyle(fontWeight: FontWeight.bold),
      ),
    ],
  );
}
