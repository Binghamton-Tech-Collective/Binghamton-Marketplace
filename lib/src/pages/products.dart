import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

import "editors/product_filters.dart";

/// The home page that lists all the products
class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  @override
  Widget build(BuildContext context, ProductsViewModel model) => Scaffold(
    appBar: AppBar(title: const Text("Home")),
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
            children: [
              const Text(
                "Shop By Category",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 24,
                ),
              ),
              const Spacer(),
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
          const SizedBox(height: 16),
          SizedBox(
            height: 50,
            child: ListView.separated(
              itemCount: Category.values.length,
              scrollDirection: Axis.horizontal,
              itemBuilder: (context, index) => CategoryFilterChip(
                  category: Category.values[index],
                  isSelected: model.filterBuilder.categories.contains(Category.values[index]),
                  onSelected: (_) => model.filterBuilder.toggleCategory(Category.values[index]),
                ),
                separatorBuilder: (context, index) => const SizedBox(width: 8),
            ),
          ),
          const SizedBox(height: 16),
          const Text(
            "View Products",
            style: TextStyle(
              fontSize: 24,
              fontWeight: FontWeight.bold,
            ),
          ),
         const SizedBox(height: 16),
          Expanded(
            child: GridView.count(
              padding: const EdgeInsets.all(16),
              shrinkWrap: true,
              crossAxisCount: 2,
              children: List.generate(
                model.productsToShow.length > model.productsPerPage
                  ? model.productsPerPage
                  : model.productsToShow.length,
                (index) => ProductWidget(
                  //product: model.productsToShow[index + model.pageNumber * model.productsPerPage],
                  product: model.productsToShow[index],
                ),
              ),
            ),
          ),
        ],
      ),
    ),
  );
}
