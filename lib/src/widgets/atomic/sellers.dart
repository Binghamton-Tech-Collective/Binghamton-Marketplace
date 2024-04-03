import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

import "package:btc_market/data.dart";

/// A reusable widget for displaying Sellers.
class SellerWidget extends StatelessWidget {
  /// The sellers to display.
  final SellerProfile seller;

  /// Constructor of the SellerWidget
  const SellerWidget({required this.seller, super.key});

  @override
  Widget build(BuildContext context) => ListTile(
    title: Text(seller.name),
    subtitle: Text(
      seller.bio,
      overflow: TextOverflow.ellipsis,
    ),
    leading: CircleAvatar(
      backgroundImage: NetworkImage(seller.imageUrl),
    ),
    onTap: () => context.go("/sellers/${seller.id.toString().trim()}".trim(), extra: seller),
  );
}
