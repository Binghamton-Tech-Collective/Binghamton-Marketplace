import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/widgets.dart";

/// A widget to show off a product.
class ProductWidget extends StatelessWidget {
  /// The product to display on this widget
  final Product product;

  /// Constructor for the Product Widget
  const ProductWidget({required this.product});

  @override
  Widget build(BuildContext context) => Card(
    child: InkWell(
      splashColor: context.colorScheme.primary.withOpacity(0.2),
      onTap: () => context.push("/products/${product.id}"),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              child: Ink.image(
                image: NetworkImage(product.imageUrls[0]),
                fit: BoxFit.contain,
              ),
            ),
          ),
          ListTile(
            subtitle: Text("\$${product.price}"),
            title: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
          ),
        ],
      ),
    ),
  );
}
