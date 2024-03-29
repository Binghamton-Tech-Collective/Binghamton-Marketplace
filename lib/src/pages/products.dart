import "package:btc_market/data.dart";
import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/src/widgets/atomic/product.dart";
import "package:btc_market/src/widgets/atomic/searchbar.dart";
import "package:btc_market/src/widgets/generic/category.dart";
import "package:btc_market/src/widgets/generic/reactive_widget.dart";
import "package:flutter/material.dart";

import "package:flutter_rating_bar/flutter_rating_bar.dart";

/// The home page that lists all the products

class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  @override
  Widget build(BuildContext context, ProductsViewModel model) {
    /// Dummy Filters to test filters
    final priceFilters = [
      r"$1 to $10",
      r"$1 to $10",
      r"$1 to $10",
      r"$1 to $10",
      r"$1 to $10",
    ];

    final productA = Product(
      id: "fsdf" as ProductID,
      sellerID: "asfsaf" as SellerID,
      userID: "asf" as UserID,
      title: "Macbook",
      description: "a new descriptions!!!",
      price: 165.80,
      quantity: 5,
      imageUrls: [
        "https://www.apple.com/newsroom/images/product/ipad/standard/apple_new-ipad-air_new-design_09152020_big.jpg.large.jpg",
      ],
      categories: {Category.clothes},
      condition: ProductCondition.new_,
      dateListed: DateTime(
        2024,
      ),
    );
    final productB = Product(
      id: "fsdf" as ProductID,
      sellerID: "asfsaf" as SellerID,
      userID: "asf" as UserID,
      title: "This is a very long and amazing title! Hopefully you like it!",
      description: "a new descriptions!!!",
      price: 165.80,
      quantity: 5,
      imageUrls: [
        "https://www.apple.com/newsroom/images/product/ipad/standard/apple_new-ipad-air_new-design_09152020_big.jpg.large.jpg",
      ],
      categories: {Category.clothes},
      condition: ProductCondition.new_,
      dateListed: DateTime(
        2024,
      ),
    );

    final productC = Product(
      id: "fsdf" as ProductID,
      sellerID: "asfsaf" as SellerID,
      userID: "asf" as UserID,
      title: "Macbook",
      description: "a new descriptions!!!",
      price: 165.80,
      quantity: 5,
      imageUrls: [
        "https://helios-i.mashable.com/imagery/reviews/03y8gbj1mqCuexgXxFJ5vyX/hero-image.fill.size_1248x702.v1623391330.jpg",
      ],
      categories: {Category.clothes},
      condition: ProductCondition.new_,
      dateListed: DateTime(
        2024,
      ),
    );
    final productD = Product(
      id: "fsdf" as ProductID,
      sellerID: "asfsaf" as SellerID,
      userID: "asf" as UserID,
      title: "This is a very long and amazing title! Hopefully you like it!",
      description: "a new descriptions!!!",
      price: 165.80,
      quantity: 5,
      imageUrls: [
        "https://picsum.photos/900/850",
      ],
      categories: {Category.clothes},
      condition: ProductCondition.new_,
      dateListed: DateTime(
        2024,
      ),
    );

    final productE = Product(
      id: "fsdf" as ProductID,
      sellerID: "asfsaf" as SellerID,
      userID: "asf" as UserID,
      title: "Macbook",
      description: "a new descriptions!!!",
      price: 165.80,
      quantity: 5,
      imageUrls: [
        "https://helios-i.mashable.com/imagery/reviews/03y8gbj1mqCuexgXxFJ5vyX/hero-image.fill.size_1248x702.v1623391330.jpg",
      ],
      categories: {Category.clothes},
      condition: ProductCondition.new_,
      dateListed: DateTime(
        2024,
      ),
    );
    final productF = Product(
      id: "fsdf" as ProductID,
      sellerID: "asfsaf" as SellerID,
      userID: "asf" as UserID,
      title: "This is a very long and amazing title! Hopefully you like it!",
      description: "a new descriptions!!!",
      price: 165.80,
      quantity: 5,
      imageUrls: [
        "https://helios-i.mashable.com/imagery/reviews/03y8gbj1mqCuexgXxFJ5vyX/hero-image.fill.size_1248x702.v1623391330.jpg",
      ],
      categories: {Category.clothes},
      condition: ProductCondition.new_,
      dateListed: DateTime(
        2024,
      ),
    );

    final productList = [
      productA,
      productB,
      productC,
      productD,
      productE,
      productF,
    ];
    return Scaffold(
      appBar: AppBar(
        backgroundColor: darkGreen,
        title: const Center(
          child: Text(
            "Home",
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 24,
            ),
          ),
        ),
      ),
      body: Column(
        children: <Widget>[
          Container(
            margin: const EdgeInsets.all(16),
            child: SearchBarWidget(),
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
                                          const Text("Sort By"),
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
                                            onSelected: (value) {},
                                            enableSearch: false,
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
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
                                          Expanded(
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: List<Widget>.from(
                                                priceFilters.map(
                                                  (filter) => FilterChip(
                                                    label: Text(filter),
                                                    onSelected: (value) {},
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      const SizedBox(height: 16),
                                      Row(
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
                                            initialRating: 5,
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
                                    ],
                                  ),
                                  Container(
                                    padding: const EdgeInsets.all(16),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: <Widget>[
                                        ElevatedButton(
                                          onPressed: () {},
                                          child: const Text(
                                            "Reset Filters",
                                          ),
                                        ),
                                        ElevatedButton(
                                          onPressed: () {},
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
              Container(
                height: 100,
                margin: const EdgeInsets.only(
                  left: 16,
                  top: 8,
                ),
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: <Widget>[
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: const BoxDecoration(),
                        child: CategoryWidget(),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                    InkWell(
                      onTap: () {},
                      child: Container(
                        decoration: BoxDecoration(
                          color: Colors.grey[300],
                        ),
                        child: CategoryWidget(),
                      ),
                    ),
                    const SizedBox(
                      width: 25,
                    ),
                  ],
                ),
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
                productList.length,
                (index) => ProductWidget(
                  product: productList[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
