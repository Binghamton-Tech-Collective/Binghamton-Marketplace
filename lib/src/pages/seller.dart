import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";

class Product {
  late final name;
  late final image;
  late final price;
}

class ProductWidget extends StatelessWidget {
  final bool isSold;
  ProductWidget([this.isSold = false]);
  
  @override
  Widget build(BuildContext context) => Card(
    child: Column(children: [
      SizedBox(height: 16),
      SizedBox(height: 150, width: 150, child: Placeholder()),
      SizedBox(height: 12),
      Text("Product title", textAlign: TextAlign.center, style: context.textTheme.titleLarge,),
      Row(children: [
        Spacer(),
        Expanded(child: Text(
          "\$49.99",
          textAlign: TextAlign.center,
          style: context.textTheme.bodyLarge,
        )),
        Expanded(child: isSold ?  
          Text("Sold", style: TextStyle(fontStyle: FontStyle.italic), textAlign: TextAlign.end)
          : TextButton(child: Text("Buy now"), onPressed: () { }),
        ),
        SizedBox(width: 8),
      ]),
    ]),
  );
}

class SellerPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Levi's Seller Profile")),
    bottomNavigationBar: BottomNavigationBar(currentIndex: 2, items: [
      BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: "Messages"),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search Products"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ]),

    body: Column(children: [
      SizedBox(height: 45),
      CircleAvatar(
        radius: 72, 
        backgroundImage: NetworkImage(
          "https://t4.ftcdn.net/jpg/03/64/21/11/360_F_364211147_1qgLVxv1Tcq0Ohz3FawUfrtONzz8nq3e.jpg",
          // scale: 5,
        ),
      ),
      SizedBox(height: 16),
      Text("Levi Lesches", style: context.textTheme.headlineLarge),
      SizedBox(height: 12),
      Text("Listed 15 products, sold 11"),
      SizedBox(height: 8),
      Row(mainAxisAlignment: MainAxisAlignment.center, children: [
        Icon(Icons.star),
        Icon(Icons.star),
        Icon(Icons.star),
        Icon(Icons.star_half),
        Icon(Icons.star_outline),
      ]),
      SizedBox(height: 8),
      Text("This is a bio about me. I love making products for Binghamton students.\nThis bio can have multiple lines, because people have a lot to say!", textAlign: TextAlign.center,),
      Divider(),
      Expanded(child: GridView.count(
        shrinkWrap: true, 
        crossAxisCount: 3, 
        childAspectRatio: 1.2,
        children: [
          for (int i = 0; i < 3; i++) ProductWidget(true),
          for (int i = 0; i < 9; i++) ProductWidget(),
        ]
      )),
    ],),
  );
}
