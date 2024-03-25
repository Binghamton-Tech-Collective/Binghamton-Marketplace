import "package:btc_market/main.dart";
import "package:btc_market/src/data/notification.dart";
import "package:btc_market/src/pages/notifications.dart";
import "package:btc_market/src/pages/seller_profile.dart";
import "package:flutter/cupertino.dart";
import "package:flutter/material.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

class ProductsPage extends ReactiveWidget<ProductsViewModel> {
  @override
  ProductsViewModel createModel() => ProductsViewModel();


  @override
  // ignore: prefer_const_constructors
  Widget build(BuildContext context, ProductsViewModel model) => Scaffold(
  backgroundColor: Colors.white,
  body: NestedScrollView(
    // ignore: prefer_expression_function_bodies
    headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
       return <Widget>[
        createSliverAppBar1(),
        createSliverAppBar2(),
      ]; 
    },
  
  body: ListView.builder(
    itemCount: 3,
    // ignore: prefer_expression_function_bodies
    itemBuilder: (context, index) {
      // ignore: prefer_const_constructors
      return Card(
        // ignore: prefer_const_constructors
        child: ListTile(
          title: const Text("Hi"),
        ),
      ); 
    }
  ),  
  ),
  );

  
  
  SliverAppBar createSliverAppBar1() {
    return SliverAppBar(
      backgroundColor: lightGrey,
      expandedHeight: 100,
      floating: false,
      elevation: 0,
      flexibleSpace: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints){
          return FlexibleSpaceBar(
            title:  const Text("HOME",
            style: TextStyle(color: Colors.white, fontSize: 30),),
            centerTitle: true,
            collapseMode: CollapseMode.parallax,
            background: Container(
            color: darkGreen,
            )
          );
        }
      )
    );
  }
  
 SliverAppBar createSliverAppBar2() {
    return SliverAppBar(
      backgroundColor: darkGreen,
      pinned: true,
      title: Container(
        margin: EdgeInsets.symmetric(horizontal: 10),
        height: 40,
        decoration: BoxDecoration(
          boxShadow: <BoxShadow>[
            BoxShadow(
                color: lightGrey,
                offset: const Offset(1.1, 1.1),
                blurRadius: 5.0),
          ],
        ),
        child: CupertinoTextField(
          keyboardType: TextInputType.text,
          placeholder: 'Search',
          placeholderStyle: TextStyle(
            color: Color(0xffC4C6CC),
            fontSize: 14.0,
            fontFamily: 'Brutal',
          ),
          prefix: Padding(
            padding: const EdgeInsets.fromLTRB(5.0, 5.0, 0.0, 5.0),
            child: Icon(
              Icons.search,
              size: 18,
              color: Colors.black,
            ),
          ),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8.0),
            color: Colors.white,
          ),
        ),
      ),
    );
  }


}