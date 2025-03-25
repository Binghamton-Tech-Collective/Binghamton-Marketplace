import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The profile page.
class SellerProfilePage extends ReactiveWidget<SellerProfileViewModel> {
  /// The ID of the seller to view.
  final SellerID id;
  /// The already-loaded seller profile
  final SellerProfile? profile;
  /// Creates the Seller Profile page. 
  const SellerProfilePage({
    required this.id,
    required this.profile,
  });
  
  @override
  SellerProfileViewModel createModel() => SellerProfileViewModel(id: id, initialProfile: profile);

  @override
  void didUpdateWidget(SellerProfilePage oldWidget, SellerProfileViewModel model) {
    if (id != model.id) {
      model.id = id;
      model.init();
    }
    super.didUpdateWidget(oldWidget, model);
  }

  /// Opens a popup to report this item
  Future<void> showReportForm(BuildContext context) async => showDialog<void>(
    context: context,
    builder: (BuildContext context) => ReportDialogue(
      type: ReportType.sellerProfile, 
      itemID: id.id,
    ),
  );

  @override
  Widget build(BuildContext context, SellerProfileViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Profile"),
      actions: [
        if (!model.isLoadingProfile) 
          if (model.profile.isUser) TextButton(
            style: TextButton.styleFrom(foregroundColor: context.colorScheme.onPrimary),
            onPressed: model.editProfile,
            child: const Text("Edit profile"),
          ) else 
          TextButton(
            onPressed: () => showReportForm(context),
            child: const Text(
              "Report",
              style: TextStyle(
                color: Colors.red,
                fontSize: 20,
              ),
            ),
        ),
      ],
    ),
    floatingActionButton: (!model.isLoadingProfile && model.profile.isUser)
      ? null : FloatingActionButton.extended(
        icon: const Icon(Icons.message),
        onPressed: model.openConversation, 
        label: const Text("Contact Seller"),
      ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    body: ListView(
      padding: const EdgeInsets.all(16),
      children: [
        if (model.isLoadingProfile) const SizedBox(height: 200, child: Center(child: CircularProgressIndicator()))
        else Row(
          children: [
            const SizedBox(width: 16),
            Hero(
              tag: "${model.profile.id}-image",
              child: CircleAvatar(
                backgroundImage: NetworkImage(model.profile.imageUrl),
                radius: 50,
              ),
            ),
            const SizedBox(width: 16),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Hero(
                    tag: "${model.profile.id}-name",
                    child: Text(
                      model.profile.name,
                      style: Theme.of(context).textTheme.headlineLarge,
                    ),
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
                      if (!model.isLoadingProducts)
                        Text(" | ${model.productList.length} Products"),
                    ],
                  ),
                  Text(
                    model.profile.bio,
                    overflow: TextOverflow.ellipsis,
                    maxLines: 5,
                  ),
                  Row(
                    children: [
                      for (final (platform, username) in model.profile.contact.socials)
                        SocialMediaButton(platform: platform, username: username),
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
            child: buildCategories(context, model),
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
        buildProducts(context, model),
      ],
    ),
  );

  /// A loading spinner, an empty message, or the seller's categories.
  Widget buildCategories(BuildContext context, SellerProfileViewModel model) =>
    model.isLoadingCategories ? const Center(child: CircularProgressIndicator())
      : model.categories.isEmpty
        ? const Center(child: Text("This seller hasn't used any categories"))
        : ListView(
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
      );

  /// A loading spinner, an empty message, or the seller's products.
  Widget buildProducts(BuildContext context, SellerProfileViewModel model) => 
    model.isLoadingProducts 
      ? const SizedBox(
        height: 200, 
        child: Center(child: CircularProgressIndicator()),
      )
      : model.productList.isEmpty
        ? const SizedBox(height: 200, child: Center(child: Text("This seller has no products")))
        : GridView.count(
          physics: const NeverScrollableScrollPhysics(),
          shrinkWrap: true,
          childAspectRatio: 0.6,
          crossAxisCount: MediaQuery.of(context).size.width ~/ ProductWidget.minWidth,
          children: [
            for (final product in model.productList) 
              ProductWidget(product: product),
          ],
        );

}
