import "package:font_awesome_flutter/font_awesome_flutter.dart";

/// A social media platform, their icons, and URLs. 
/// 
/// You can use [icon] and [getUrl] in the UI code to show a button that opens the URL.
enum SocialMediaPlatform {
  /// Instagram's icon and URL.
  instagram(
    icon: FaIcon(FontAwesomeIcons.instagram),
    urlPrefix: "https://instagram.com/",
  ),
  /// TikTok's icon and URL.
  tiktok(
    icon: FaIcon(FontAwesomeIcons.tiktok),
    urlPrefix: "https://www.tiktok.com/@",
  ),
  /// LinkedIn's icon. LinkedIn URLs are unpredictable and should be given by the user.
  linkedin(
    icon: FaIcon(FontAwesomeIcons.linkedinIn),
  ),
  /// Twitter/X's icon and URL.
  twitter(
    icon: FaIcon(FontAwesomeIcons.xTwitter),
    urlPrefix: "https://twitter.com/",
  );
  
  /// The URL prefix that goes before the username, if any. 
  /// 
  /// If this is null, the user should pass in their full URL to [getUrl].
  final String? urlPrefix;

  /// A widget to show for this platform's icon.
  final FaIcon icon;
  
  const SocialMediaPlatform({
    required this.icon,
    this.urlPrefix,
  });

  /// Gets the URL for the given user's profile page on this platform.
  String getUrl(String username) => urlPrefix == null
    ? username : "$urlPrefix$username";
}
