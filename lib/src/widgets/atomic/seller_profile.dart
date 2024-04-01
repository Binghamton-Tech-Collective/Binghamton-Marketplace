import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/widgets.dart";

/// A widget to show off a [SellerProfile].
class SellerProfileWidget extends StatelessWidget {
  /// THe profile being displayed.
  final SellerProfile profile;
  /// The average rating of this user, if known.
  final double? averageRating;
  /// Creates a widget to show off a seller's profile.
  const SellerProfileWidget({
    required this.profile,
    required this.averageRating,
  });

  @override
  Widget build(BuildContext context) => ListTile(
    leading: Hero(tag: "profile-pic", child: CircleAvatar(backgroundImage: NetworkImage(profile.imageUrl),),),
    title: Text(profile.name),
    onTap: () => context.push("/sellers/${profile.id}"),
    subtitle: averageRating == null ? null : RatingBarIndicator(
      rating: averageRating!,
      itemSize: 15,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
    ),
    trailing: SizedBox(
      width: 200,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          IconButton(
            onPressed: () { },
            iconSize: 36,
            icon: const Icon(Icons.facebook),
          ),
          IconButton(
            onPressed: () {},
            iconSize: 36,
            icon: const Icon(Icons.tiktok),
          ),
        ],
      ),
    ),
  );
}
