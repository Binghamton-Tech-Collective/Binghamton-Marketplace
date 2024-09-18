import "package:flutter/material.dart";
import "package:url_launcher/url_launcher.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

import "editors/product_filters.dart";

/// The home page that lists all the products
class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  void didUpdateWidget(ProductsPage oldWidget, ProductsViewModel model) {
    model.queryProducts();
    super.didUpdateWidget(oldWidget, model);
  }
  
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  @override
  Widget build(BuildContext context, ProductsViewModel model) => Scaffold(
    appBar: AppBar(
      title: const Text("Browse products"),
      actions: [
        IconButton(
          onPressed: () => launchUrl(Uri.parse("https://forms.gle/fqDYHYx5EHtpbT129")),
          icon: const Icon(Icons.feedback),
          tooltip: "Submit feedback",
        ),
        ProfileButton(),
      ],
    ),
    body: Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          if (model.isSearching) const LinearProgressIndicator(),
          SearchBar(
            leading: const Icon(Icons.search),
            hintText: "Search Products",
            controller: model.searchController,
            onSubmitted: (searchQuery) => model.queryProducts(),
            trailing: [
              if (model.searchQuery.isNotEmpty) IconButton(
                icon: const Icon(Icons.close),
                onPressed: model.clearSearch,
              ),
            ],
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text(
                "Categories",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              OutlinedButton.icon(
                icon: const Icon(Icons.tune),
                label: const Text("More filters"),
                onPressed: () => showModalBottomSheet<void>(
                  context: context,
                  builder: (context) => ProductFiltersEditor(model.filterBuilder),
                ),
              ),
            ],
          ),
          const SizedBox(height: 8),
          SizedBox(
            height: 40,
            child: ListView(
              scrollDirection: Axis.horizontal,
              children: [
                for (final category in Category.values) Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: CategoryFilterChip(
                    category: category,
                    isSelected: model.filterBuilder.categories.contains(category),
                    onSelected: (_) => model.filterBuilder.toggleCategory(category),
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(height: 12),
          const Text(
            "View Products",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 4),
          Expanded(
            child: model.productsToShow.isEmpty 
              ? Center(child: Text("No products match your query", style: context.textTheme.titleLarge)) 
              : GridView.count(
              shrinkWrap: true,
              crossAxisCount: MediaQuery.of(context).size.width ~/ ProductWidget.minWidth,
              children: [
                for (final product in model.productsToShow.take(model.productsPerPage))
                  ProductWidget(product: product),
              ],
            ),
          ),
        ],
      ),
    ),
  );
}
