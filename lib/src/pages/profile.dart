import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// The profile page.
class ProfilePage extends ReactiveWidget<ProfileViewModel> {
  @override
  ProfileViewModel createModel() => ProfileViewModel();

  @override
  Widget build(BuildContext context, ProfileViewModel model) => Scaffold(
    body: CustomScrollView(
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
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      SizedBox(width: 50),
                      Text("Bio"),
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 110,
                  left: 125,
                  child: Row(
                    children: [
                      Text("Contact Placeholder"),
                    ],
                  ),
                ),
                const Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Divider(
                    indent: 20,
                    thickness: 3,
                    endIndent: 20,
                    color: Colors.grey,
                  ),
                ),
              ],
            ),
          ),
        ),
        SliverToBoxAdapter(
            child: Column(
              children: [
                const Text("Seller Categories",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                SizedBox(
                  height: 100,
                  child: ListView.separated(
                   itemBuilder: (_,i) => const CircleAvatar(
                     backgroundColor: Colors.red,
                     radius: 40,
                   ), 
                   separatorBuilder: (BuildContext context, int index) => const SizedBox(
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
            margin: const EdgeInsets.all(15),
            color: Colors.white,
            height: 170,
            child: Stack(
              children: [
                const Text(
                  "Listings",
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                ListView.separated(
                  itemBuilder: (_,i) => const SizedBox(
                    width: 170,
                    child: Placeholder(),
                  ), 
                  separatorBuilder: (BuildContext context, int i) => const SizedBox(
                    width: 20,
                  ), 
                  itemCount: 10,
                  scrollDirection: Axis.horizontal,
                  ),
              ],
            ),
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
    
  );
}
