import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

import "package:flutter_rating_bar/flutter_rating_bar.dart";

/// The home page that lists all the products
class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  @override
  Widget build(BuildContext context, ProductsViewModel model) =>
    Scaffold(
      appBar: AppBar(title: const Text("Home")),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16),
            child: SearchBar(
              controller: model.searchController,
              leading: const Icon(Icons.search),
              trailing: [
                if (model.searchQuery.isNotEmpty) IconButton(
                  icon: const Icon(Icons.close),
                  onPressed: model.clearSearch,
                ),
              ],
              onSubmitted: (String searchQuery) => model.queryProducts(
                searchQuery: searchQuery,
              ),
            ),
          ),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                padding: const EdgeInsets.all(16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: const Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          "Shop By Categories",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 24,
                          ),
                        ),
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(
                        left: 16,
                      ),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          backgroundColor: darkGreen,
                        ),
                        onPressed: () {
                          showModalBottomSheet<void>(
                            context: context,
                            builder: (BuildContext context) =>
                                SingleChildScrollView(
                              child: Column(
                                children: [
                                  ListView(
                                    padding: const EdgeInsets.all(16),
                                    shrinkWrap: true,
                                    children: <Widget>[
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "Filters",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text(
                                              "Close Filters",
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
                                        mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                        children: <Widget>[
                                          const Text(
                                            "Sort By",
                                            style: TextStyle(
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                          DropdownMenu<ProductSortOrder>(
                                            dropdownMenuEntries: [
                                              for (final sortOrder
                                                  in ProductSortOrder.values)
                                                DropdownMenuEntry(
                                                  value: sortOrder,
                                                  label: sortOrder.displayName,
                                                ),
                                            ],
                                            hintText: "Select",
                                            onSelected: (value) => model.updateSortOrder(value ?? ProductSortOrder.byNew),
                                            enableSearch: false,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      ValueListenableBuilder<ProductSortOrder>(
                                        valueListenable: model.sortOrderNotifier,
                                        builder: (context, range, child) =>
                                          Visibility(
                                            visible: model.sortOrder == ProductSortOrder.byPriceAscending || model.sortOrder == ProductSortOrder.byPriceDescending,
                                            child: Row(
                                              crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                const Expanded(
                                                  child: Text(
                                                    "Price",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                ValueListenableBuilder<RangeValues>(
                                                  valueListenable: model.priceRangeNotifier,
                                                  builder: (context, range, child) =>
                                                    RangeSlider(
                                                      values: range,
                                                      max: 100,
                                                      divisions: 25,
                                                      labels: RangeLabels(
                                                        range.start.round().toString(),
                                                        range.end.round().toString(),
                                                      ),
                                                      onChanged: (values) {
                                                        model.changePriceRange(values);
                                                      },
                                                    ),
                                                ),
                                              ],
                                            ),
                                          ),
                                      ),
                                      const SizedBox(height: 16),
                                      ValueListenableBuilder<ProductSortOrder>(
                                        valueListenable: model.sortOrderNotifier,
                                        builder: (context, range, child) =>
                                          Visibility(
                                            visible: model.sortOrder == ProductSortOrder.byRating,
                                            child: Row(
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              mainAxisAlignment:
                                                  MainAxisAlignment.spaceEvenly,
                                              children: <Widget>[
                                                const Expanded(
                                                  child: Text(
                                                    "Ratings",
                                                    style: TextStyle(
                                                      fontWeight: FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                                RatingBar(
                                                  initialRating: model.minRating as double,
                                                  ratingWidget: RatingWidget(
                                                    full: const Icon(
                                                      Icons.star,
                                                      color: darkGreen,
                                                    ),
                                                    half: const Icon(
                                                      Icons.star_half,
                                                      color: darkGreen,
                                                    ),
                                                    empty: const Icon(
                                                      Icons.star_border,
                                                      color: darkGreen,
                                                    ),
                                                  ),
                                                  onRatingUpdate: (value) {},
                                                ),
                                              ],
                                            ),
                                          ),
                                      ),
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () => model.applyDefaultFilters(),
                                          child: const Text(
                                            "Reset Filters",
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {
                                            model.queryProducts();
                                            Navigator.of(context).pop();
                                          },
                                          child: const Text(
                                            "Apply",
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                        child: const Text(
                          "More filters",
                          style: TextStyle(
                            color: Colors.white,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: <Widget>[
                  for (final category in Category.values) CategoryFilterChip(
                    category: category,
                    isSelected: model.categories.contains(category),
                    onSelected: (_) => model.toggleCategory(category),
                  ),
                ],
              ),
            ],
          ),
          Container(
            margin: const EdgeInsets.only(
              top: 8,
              left: 16,
              bottom: 16,
            ),
            child: const Align(
              alignment: Alignment.centerLeft,
              child: Text(
                "View Products",
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),
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
    );
}
