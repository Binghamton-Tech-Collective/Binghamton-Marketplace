import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/widgets.dart";

/// A widget to show off a [SellerProfile].
class SellerProfileWidget extends StatelessWidget {
  /// The profile being displayed.
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
    leading: Hero(
      tag: "${profile.id}-image",
      child: CircleBtcImage(
        image: NetworkImage(profile.imageUrl),
      ),
    ),
    title: Hero(
      tag: "${profile.id}-name",
      child: Text(profile.name),
    ),
    onTap: () => context.push("/sellers/${profile.id}", extra: profile),
    subtitle: averageRating == null ? null : RatingBarIndicator(
      rating: averageRating!,
      itemSize: 15,
      itemBuilder: (context, _) => const Icon(
        Icons.star,
        color: Colors.amber,
      ),
    ),
    trailing: Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        for (final (platform, username) in profile.contact.socials)
          Flexible(child: SocialMediaButton(platform: platform, username: username)),
      ],
    ),
  );
}
