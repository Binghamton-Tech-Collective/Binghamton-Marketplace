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
          Card(
            clipBehavior: Clip.none,
            child: InkWell(
              splashColor: Colors.blue.withAlpha(30),
              onTap: () {
                GoRouter.of(context).push("/products/${product.id}");
              },
              child: SizedBox(
                width: 170,
                height: 130,
                child: Image(
                  image: NetworkImage(product.imageUrls[0]),
                ),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(6),
            child: Text(
              overflow: TextOverflow.ellipsis,
              maxLines: 1,
              "\$${product.price} - ${product.title}",
              style: const TextStyle(fontWeight: FontWeight.bold),
            ),
          ),
        ],
      );
}
