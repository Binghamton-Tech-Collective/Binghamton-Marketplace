import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// A widget to show off a product.
class ProductWidget extends StatelessWidget{
  /// An empty constructor
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
            //debugPrint("Card Tapped");
            GoRouter.of(context).push("/products/QnYb1Mz5eZV9jMQlQh4i");
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
