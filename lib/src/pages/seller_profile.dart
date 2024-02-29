import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";

/// The profile page.
class SellerProfilePage extends ReactiveWidget<SellerProfileViewModel> {
  @override
  SellerProfileViewModel createModel() => SellerProfileViewModel();

  @override
  Widget build(BuildContext context, SellerProfileViewModel model) => Scaffold(
    body: Center(child: model.isLoading
      ? const CircularProgressIndicator()
      : CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            collapsedHeight: 60,
            pinned: true,
            backgroundColor: Colors.white,
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                children: [
                  Align(
                    alignment: Alignment.topCenter,
                    child: Container(
                      height: 150,
                      color: const Color.fromARGB(255, 0, 65, 44),
                      alignment: const Alignment(0.75, 1),
                      child: Text(
                        "Samuel Montes",
                        style: Theme.of(context).textTheme.headlineLarge
                        ?.copyWith(color: Colors.white),
                      ),
                    ),
                  ),
                  const Positioned(
                    bottom: 100,
                    left: 20,
                    child: CircleAvatar(
                      backgroundImage: NetworkImage("https://media.licdn.com/dms/image/D4E03AQH1m-DsPxkXkQ/profile-displayphoto-shrink_800_800/0/1663694541598?e=2147483647&v=beta&t=jbiXqn5fY7dJUCgtYZ9a_KZrYWRmCHzg0YkJBdGoURg"),
                      radius: 50,
                    ),
                  ),
                  const Positioned(
                    bottom: 130,
                    left: 125,
                    child: Row(
                      children: [
                        Text("Computer Science",
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 15),
                        ),
                        SizedBox(width: 50),
                      ], 
                    ),
                  ),
                  const Positioned(
                    left: 300,
                    top: 150,
                    child: SizedBox(
                          width: 200,
                          height: 200,
                          child: Text("Lorem ipsum dolor sit amet, consectetur adipiscing elit. Proin eleifend turpis mauris.",
                            overflow: TextOverflow.ellipsis,
                            maxLines: 3,
                          ),
                         ),
                        ),
                   Positioned(
                    bottom: 90,
                    left: 125,
                    child: Row(
                      children: [
                        ActionChip(
                          avatar: const Icon(Icons.phone),
                          shape: const StadiumBorder(),
                          label: const Text("Call"),
                          onPressed: () {},
                        ),
                        const VerticalDivider(
                          width: 4,
                        ),
                        ActionChip(
                          avatar: const Icon(Icons.email),
                          shape: const StadiumBorder(),
                          label: const SizedBox(),
                          onPressed: () {},
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    color: Colors.grey,
                    thickness: 3,
                  ),
                  const Padding(
                    padding: EdgeInsets.only(left: 15),
                    child: Text("Seller Categories",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.only(left: 15, right: 15),
                    child: SizedBox(
                      height: 125,
                      child: ListView.separated(
                        itemBuilder: (_,i) => const Column(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children:  [
                             CircleAvatar(backgroundColor: Colors.red, radius: 40),
                             SizedBox(height: 10),
                             Text("Test"),
                          ],
                        ),
                        separatorBuilder: (BuildContext context, int index) => const SizedBox(
                          width: 20,
                        ), 
                        itemCount: 10,
                        scrollDirection: Axis.horizontal,
                      ),
                    ), 
                  ), 
                  const Divider(
                    indent: 20,
                    endIndent: 20,
                    thickness: 3,
                    color: Colors.grey,
                  ),
                ],
              ),
            ),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Padding(
                  padding: EdgeInsets.only(left: 15),
                  child: Text(
                    "Listings",
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(15),
                  height: 200,
                  child: ListView.separated(
                    itemBuilder: (_,i) => const SizedBox(
                      width: 170,
                      child: ProductWidget(),
                    ), 
                    separatorBuilder: (BuildContext context, int i) => const SizedBox(
                      width: 20,
                    ), 
                    itemCount: 10,
                    scrollDirection: Axis.horizontal,
                  ),
                ),
              ],
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              height: 1000,
              color: Colors.grey,
            ),
          ),
        ],
      ),
    ),
  );
}
