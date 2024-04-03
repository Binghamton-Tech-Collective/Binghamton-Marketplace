import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/widgets.dart";
import "package:font_awesome_flutter/font_awesome_flutter.dart";
import "package:url_launcher/url_launcher.dart";

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
          if (profile.contact.instagramHandle != null) IconButton(
            onPressed: () async {
              await launchUrl(Uri.parse("https://instagram.com/${profile.contact.instagramHandle}"));
            },
            iconSize: 20,
            icon: const FaIcon(FontAwesomeIcons.instagram),
          ),
          if (profile.contact.tikTokUsername != null) IconButton(
            onPressed: () async { 
              await launchUrl(Uri.parse("https://www.tiktok.com/@${profile.contact.tikTokUsername}"));
            },
            iconSize: 20,
            icon: const FaIcon(FontAwesomeIcons.tiktok),
          ),
          if (profile.contact.linkedInUsername != null) IconButton(
            onPressed: () async{ 
              await launchUrl(Uri.parse(profile.contact.linkedInUsername!));
            },
            iconSize: 20,
            icon: const FaIcon(FontAwesomeIcons.linkedin),
          ),
          if (profile.contact.twitterUsername != null) IconButton(
            onPressed: () async{ 
              await launchUrl(Uri.parse("https://twitter.com/${profile.contact.twitterUsername}"));
            },
            iconSize: 20,
            icon: const FaIcon(FontAwesomeIcons.x),
          ),
        ],
      ),
    ),
  );
}
