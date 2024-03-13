import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";

/// The Product Editor/Creator page.
class ProductEditor extends ReactiveWidget<ProductBuilder> {
  @override
  ProductBuilder createModel() => ProductBuilder();
  
  @override
  Widget build(BuildContext context, ProductBuilder model) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
          title: const Text(),
        ),
        body: Center(
          child: ListView(
            children: const [
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Name of the Item:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Item Name",
                      ),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  children: <Widget>[
                    Text(
                      "Price of the Item:",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    TextField(
                      decoration: InputDecoration(
                        border: OutlineInputBorder(),
                        hintText: "Item Price",
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}


// The main function is the starting point for all our Apps
// The Material app is the parent of all the widgets that we've used in our App

// enum Conditions { condition1, condition2, condition3, condition4 }

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'flutter demo',
//       home: MyHomePage(title: 'flutter dropdown'),
//     );
//   }
// }

// class MyHomePage extends StatefulWidget {
//   MyHomePage({Key? key, required this.title}) : super(key: key);

//   final String title;

//   @override
//   _MyHomePageState createState() => _MyHomePageState();
// }

// class _MyHomePageState extends State<MyHomePage> {
//   String? valueChoose;
//   List<String> listItems = [
//     "condition1",
//     "condition2",
//     "condition3",
//     "condition4"
//   ];

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
//         title: const Text("List Item"),
//       ),
//       body: Center(
//         child: ListView(
//           children: [
//             Padding(
//               padding: const EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Name of Item",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   TextField(
//                     decoration: const InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Item Name",
//                     ),
//                   )
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Price",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Price of the Item",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Condition of the Product",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   Container(
//                       padding: EdgeInsets.all(6.0),
//                       decoration: BoxDecoration(
//                         border: Border.all(color: Colors.grey, width: 1),
//                         borderRadius: BorderRadius.circular(15),
//                       ),
//                       child: DropdownButton(
//                           items: listItems.map(
//                             (valueItem) {
//                               return DropdownMenuItem(
//                                 value: valueItem,
//                                 child: Text(valueItem),
//                               );
//                             },
//                           ).toList(),
//                           hint: Text("Condition"),
//                           dropdownColor: Colors.white,
//                           icon: Icon(Icons.arrow_drop_down),
//                           iconSize: 36,
//                           isExpanded: true,
//                           underline: SizedBox(),
//                           style: TextStyle(
//                             color: Colors.black,
//                             fontSize: 22,
//                           ),
//                           value: valueChoose,
//                           onChanged: (newValue) {
//                             setState(
//                               () {
//                                 valueChoose = newValue;
//                               },
//                             );
//                           }))
//                 ],
//               ),
//             ),
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     "Description",
//                     style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                   ),
//                   TextField(
//                     decoration: InputDecoration(
//                       border: OutlineInputBorder(),
//                       hintText: "Enter Product Description",
//                     ),
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

