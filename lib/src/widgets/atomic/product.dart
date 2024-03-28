import "package:btc_market/data.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// A widget to show off a product.
class ProductWidget extends StatelessWidget {
  /// The product to diplay on this widget
  final Product product;

  /// Constructor for the Product Widget
  const ProductWidget({required this.product});

  @override
  Widget build(BuildContext context) => Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            child: Align(
              child: Card(
                clipBehavior: Clip.none,
                child: InkWell(
                  splashColor: Colors.blue.withAlpha(30),
                  onTap: () {
                    GoRouter.of(context).push("/products/${product.id}");
                  },
                  child: Image(
                    image: NetworkImage(product.imageUrls[0]),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
            ),
          ),
          ListTile(
            title: Text(
              product.title,
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
            ),
            subtitle: Text("\$${product.price}"),
          ),
        ],
      );
}