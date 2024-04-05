import "package:btc_market/data.dart";
import "package:flutter/material.dart";
import "package:url_launcher/url_launcher_string.dart";

/// A button to show an icon for a [SocialMediaPlatform] and open [username]'s profile page.
class SocialMediaButton extends StatelessWidget {
  /// The platform for this widget to show. Controls the icon and URL.
  final SocialMediaPlatform platform;
  /// The username to open to.
  final String username;
  /// Creates a widget to open the given user's social media page.
  const SocialMediaButton({
    required this.platform,
    required this.username,
  });

  @override
  Widget build(BuildContext context) => IconButton(
    icon: platform.icon,
    onPressed: () => launchUrlString(platform.getUrl(username)),
  );
}
