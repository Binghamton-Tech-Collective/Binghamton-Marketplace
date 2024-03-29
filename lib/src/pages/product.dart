import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The products page.
class ProductPage extends ReactiveWidget<ProductViewModel>{
  /// ID of product
  final ProductID id;
  /// const constructor
  const ProductPage(this.id);
  
  @override
  ProductViewModel createModel() => ProductViewModel(id);

  @override
  void didUpdateWidget(ProductPage oldWidget, ProductViewModel model) {
    model.id = id;
    model.init();
    super.didUpdateWidget(oldWidget, model);
  }

  @override
  Widget build(BuildContext context, ProductViewModel model) => Scaffold(
    appBar: AppBar(
      backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
      title: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Text("Item Details",
            style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold, fontSize: 24),
          ),
          if (model.product.isSeller) IconButton(
              icon: const Icon(Icons.edit),
              onPressed: () => model.editProduct(model.id),
            ),
        ],
      ),
    ),
    body: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: Column(children: [
        Expanded(child: ListView(
          children: [
            // ---------- Image gallery ----------
            SizedBox(height: 400, child: GalleryWidget(
              children: [
                for (final imageUrl in model.product.imageUrls) Image.network(
                  imageUrl, 
                  fit: BoxFit.cover, 
                ),
              ],
            ),),
            
            // ---------- Name, price, and condition ----------
            const SizedBox(height: 24),
            Expanded(child: Text(model.product.title, style: context.textTheme.headlineLarge)),
            const SizedBox(height: 12),
            Row(
              children: [
                Text("\$${model.product.price}", style: context.textTheme.titleLarge),
                const Spacer(),
                Text("Condition: ${model.product.condition.displayName}", style: context.textTheme.titleMedium),
              ],
            ),
            const SizedBox(height: 8),
            if (model.averageRating != null) Row(children: [
              Text("User rating: ", style: context.textTheme.bodyLarge), 
              const SizedBox(width: 8),
              RatingBarIndicator(
                rating: model.averageRating! as double, 
                itemSize: 20,
                itemBuilder: (context, _) => const Icon(
                  Icons.star,
                  color: Colors.amber,
                ),
              ),
            ],),
            
            // ---------- Description ----------
            const SizedBox(height: 8),
            Text("Description", style: context.textTheme.titleLarge),
            const SizedBox(height: 8),
            Text(model.product.description, style: context.textTheme.bodyLarge),
            
            // ---------- Categories ----------
            const SizedBox(height: 12), 
            Text("Categories", style: context.textTheme.titleLarge),
            const SizedBox(height: 8),
            Wrap(children: [
              for (final category in model.product.categories) ...[
                Chip(
                  label: Text(category.title),
                  labelStyle: const TextStyle(color: Colors.white),
                  backgroundColor: Colors.grey,
                  shape: const StadiumBorder(),
                ),
                const SizedBox(width: 8),
              ],
            ],),

            // ---------- Seller Profile ----------
            const SizedBox(height: 12),
            Text("Sold by", style: context.textTheme.titleLarge),
            SellerProfileWidget(
              profile: model.sellerProfile, 
              averageRating: model.sellerRating as double?,
            ),
          ],
        ),),
        const SizedBox(height: 8),
        SizedBox(width: double.infinity, height: 48, child: ElevatedButton(
          onPressed: model.openConversation,
          style: ElevatedButton.styleFrom(backgroundColor: const Color.fromRGBO(0, 90, 67, 1)),
          child: const Text("Contact Seller", style: TextStyle(color: Colors.white)),
        ),),
        const SizedBox(height: 8),
      ],),
    ),),
  );
}
