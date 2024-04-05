import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The products page.
class ProductPage extends ReactiveWidget<ProductViewModel>{
  /// ID of product
  final ProductID id;

  /// The already-loaded product, if any.
  final Product? product;
  
  /// const constructor
  const ProductPage({
    required this.id, 
    required this.product,
  });
  
  @override
  ProductViewModel createModel() => ProductViewModel(
    id: id,
    initialProduct: product,
  );

  @override
  void didUpdateWidget(ProductPage oldWidget, ProductViewModel model) {
    if (oldWidget.id != id) {
      model.id = id;
      model.init();
    }
    super.didUpdateWidget(oldWidget, model);
  }

  @override
  Widget build(BuildContext context, ProductViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Item Details"),
      actions: [
        if (model.product.isSeller) TextButton(
          style: TextButton.styleFrom(foregroundColor: context.colorScheme.onPrimary),
          onPressed: () => model.editProduct(model.id),
          child: const Text("Edit product"),
        ),
      ],
    ),
    floatingActionButton: FloatingActionButton.extended(
      icon: const Icon(Icons.message),
      onPressed: model.openConversation, 
      label: const Text("Contact Seller"),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    body: Center(child: ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: 500),
      child: ListView(
        padding: const EdgeInsets.all(16),
        children: [
          // ---------- Image gallery ----------
          SizedBox(height: 400, child: GalleryWidget(product: model.product)),
          
          // ---------- Name, price, and condition ----------
          const SizedBox(height: 24),
          Hero(
            tag: "${model.product.id}-name",
            child: Text(model.product.title, style: context.textTheme.headlineLarge),
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text("\$${model.product.price}", style: context.textTheme.titleLarge),
              const Spacer(),
              Text("Condition: ${model.product.condition.displayName}", style: context.textTheme.titleMedium),
            ],
          ),
          const SizedBox(height: 8),
          if (!model.loadingDetails && model.averageRating != null) Row(children: [
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
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: [
              for (final category in model.product.categories)
                CategoryChip(category),
            ],
          ),
      
          // ---------- Seller Profile ----------
          if (!model.loadingDetails) ...[
            const SizedBox(height: 12),
            Text("Sold by", style: context.textTheme.titleLarge),
            SellerProfileWidget(
              profile: model.sellerProfile, 
              averageRating: model.sellerRating as double?,
            ),
            const SizedBox(height: 48),
          ],
        ],
      ),
    ),),
  );
}
