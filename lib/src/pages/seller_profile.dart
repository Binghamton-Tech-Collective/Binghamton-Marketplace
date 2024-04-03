import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The profile page.
class SellerProfilePage extends ReactiveWidget<SellerProfileViewModel> {
  /// The ID of the seller to view.
  final SellerID id;
  /// Creates the Seller Profile page. 
  const SellerProfilePage(this.id);
  
  @override
  SellerProfileViewModel createModel() => SellerProfileViewModel(id);

  @override
  void didUpdateWidget(SellerProfilePage oldWidget, SellerProfileViewModel model) {
    model.id = id;
    model.init();
    super.didUpdateWidget(oldWidget, model);
  }

  @override
  Widget build(BuildContext context, SellerProfileViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Profile"),
      actions: [
        if (model.profile.userID == models.user.userProfile!.id) TextButton(
          onPressed: model.editProfile,
          child: Text("Edit profile", style: TextStyle(color: context.colorScheme.onPrimary)),
        ),
      ],
    ),
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Row(
          children: [
            const SizedBox(width: 16),
            CircleAvatar(
              backgroundImage: NetworkImage(model.profile.imageUrl),
              radius: 50,
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    model.profile.name,
                    style: Theme.of(context).textTheme.headlineLarge,
                  ),
                  Row(
                    children: [
                      RatingBarIndicator(
                        rating: 5,
                        itemSize: 20,
                        itemBuilder: (context, _) => const Icon(
                          Icons.star,
                          color: Colors.amber,
                        ),
                      ),
                      Text(" | ${model.productList.length} Products"),
                    ],
                  ),
                  Text(model.profile.bio,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                  Row(
                    children: [
                      for (final (platform, username) in model.profile.contact.socials)
                        SocialMediaButton(platform: platform, username: username),
                      OutlinedButton.icon(
                        onPressed: model.openConversation,
                        icon: const Icon(Icons.message),
                        label: const Text("Message"),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(
          color: Colors.grey,
          thickness: 3,
        ),
        Text(
          "Product Categories",
          style: context.textTheme.headlineMedium,
        ),
        Container(
          padding: const EdgeInsets.only(left: 15, right: 15),
          child: SizedBox(
            height: 110,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final category in model.categories) Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children:  [
                    Padding(
                      padding: const EdgeInsets.only(left: 10, right: 10),
                      child: CircleAvatar(
                        radius: 40,
                        backgroundColor: Colors.transparent, // Set background color to transparent
                        child: ClipOval(
                          child: Image(
                            image: AssetImage(category.imagePath),
                            fit: BoxFit.cover, // Adjust the fit to cover the entire circular area
                          ),
                        ),
                      ),
                    ),
                    Text(category.title),
                  ],
                ),
              ],
            ),
          ), 
        ), 
        const Divider(
          thickness: 3,
          color: Colors.grey,
        ),
        Text(
          "Listings",
          style: context.textTheme.headlineMedium,
        ),
        const SizedBox(height: 12),
        GridView.count(
          shrinkWrap: true,
          crossAxisCount: 3,
          children: [
            for (final product in model.productList) 
              ProductWidget(product: product),
          ],
        ),
      ],
    ),
  );
}
