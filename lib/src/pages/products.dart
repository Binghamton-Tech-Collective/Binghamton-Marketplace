import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";

class ProductWidget extends StatelessWidget {
  final bool isSold;
  ProductWidget([this.isSold = false]);
  
  @override
  Widget build(BuildContext context) => Card(
    child: Column(children: [
      SizedBox(height: 16),
      SizedBox(height: 150, width: 150, child: Placeholder()),
      SizedBox(height: 16),
      Text("Product title", textAlign: TextAlign.center, style: context.textTheme.titleLarge,),
      SizedBox(height: 8),
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

class ProductsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(title: Text("Browse Products")),
    bottomNavigationBar: BottomNavigationBar(currentIndex: 1, items: [
      BottomNavigationBarItem(icon: Icon(Icons.chat_outlined), label: "Messages"),
      BottomNavigationBarItem(icon: Icon(Icons.search), label: "Search Products"),
      BottomNavigationBarItem(icon: Icon(Icons.person), label: "Profile"),
    ]),
    body: Padding(padding: EdgeInsets.symmetric(horizontal: 16), child: Column(children: [
      SizedBox(height: 16),
      SizedBox(width: double.infinity, child: SearchBar(
        leading: SizedBox(width: 12),
        hintText: "Enter a product or seller name",
        trailing: [IconButton(icon: Icon(Icons.search_outlined), onPressed: () { },)],
      ),),
      SizedBox(height: 16),
      Row(children: [
        Chip(
          label: Text("All Filters"),
          avatar: Icon(Icons.filter_list_outlined)
        ),
        SizedBox(width: 8),
        for (final tag in ["Lifestyle", "School supplies", "Clothing"]) 
          ...[ Chip(label: Text(tag), onDeleted: () { }, deleteIcon: Icon(Icons.close)), SizedBox(width: 8), ]
      ],),
      Divider(),
      Expanded(child: GridView.count(
        crossAxisCount: 3,
        childAspectRatio: 1.1,
        children: [
          for (int i = 0; i < 12; i++) 
            ProductWidget(),
        ]
      )),
    ],),),
  );
}
