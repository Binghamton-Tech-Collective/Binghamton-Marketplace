import "package:btc_market/data.dart";
import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/src/widgets/atomic/product.dart";
import "package:btc_market/src/widgets/generic/reactive_widget.dart";
import "package:flutter/material.dart";

/// The home page that lists all the products

class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();

  @override
  Widget build(BuildContext context, ProductsViewModel model) {
    /// Dummy Filters to test filters
    final sortFilters = [
      "price: low to high",
      "price: high to low",
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
            child: SearchBar(),
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
                            builder: (BuildContext context) => Container(
                              height: 600,
                              color: Colors.grey[300],
                              child: Container(
                                padding: const EdgeInsets.all(10),
                                child: Column(
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
                                          child: const Text("Close Filters"),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      margin: const EdgeInsets.all(
                                        16,
                                      ),
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
                                          Expanded(
                                            flex: 3,
                                            child: Wrap(
                                              alignment: WrapAlignment.center,
                                              spacing: 8,
                                              runSpacing: 8,
                                              children: List<Widget>.from(
                                                sortFilters.map(
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
                                    ),
                                  ],
                                ),
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
                model.productsToShow.length,
                (index) => ProductWidget(
                  product: model.productsToShow[index],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

/// SearchBar widget
class SearchBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: darkGreen,
        ),
        child: TextField(
          style: const TextStyle(color: Colors.white),
          textAlign: TextAlign.left,
          decoration: InputDecoration(
            hintText: "Search here",
            hintStyle: const TextStyle(
              color: Colors.white,
            ),
            prefixIcon: InkWell(
              onTap: () {},
              child: const Icon(
                Icons.search,
                color: Colors.white,
              ),
            ),
            border: InputBorder.none, // Remove the default border
            contentPadding: const EdgeInsets.symmetric(
              horizontal: 16,
              vertical: 14,
            ),
          ),
        ),
      );
}

/// Resusable circular widget for showing categories
class CategoryWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) => const Column(
        children: <Widget>[
          CircleAvatar(
            radius: 30,
            backgroundImage: NetworkImage(
              "https://media.licdn.com/dms/image/D4E03AQH1m-DsPxkXkQ/profile-displayphoto-shrink_800_800/0/1663694541598?e=2147483647&v=beta&t=jbiXqn5fY7dJUCgtYZ9a_KZrYWRmCHzg0YkJBdGoURg",
            ),
          ),
          Text(
            "Textbooks",
            style: TextStyle(
              fontSize: 14,
            ),
          ),
        ],
      );
}

// ElevatedButton(
//                                       child: const Text("Close BottomSheet"),
//                                       onPressed: () => Navigator.pop(context),
//                                     ),
