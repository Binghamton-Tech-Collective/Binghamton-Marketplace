import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";
import "package:btc_market/data.dart";

/// The Product Editor/Creator page.
class ProductEditor extends ReactiveWidget<ProductBuilder> {
  @override
  ProductBuilder createModel() => ProductBuilder();

  @override
  Widget build(BuildContext context, ProductBuilder model) => Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(0, 90, 67, 1),
          title: const Text("List Item"),
        ),
        body: Center(
          child: ListView(
            children: [
              InputContainer(
                text: "Name of the Item",
                hint: "Item Name",
                controller: model.titleController,
              ),
              InputContainer(
                text: "Price of the Item",
                hint: "Item Price",
                controller: model.priceController,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      "Condition of the Product",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    Container(
                      padding: const EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey),
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: DropdownButton<ProductCondition>(
                        items: [
                          for (final condition in ProductCondition.values)
                            DropdownMenuItem(
                              value: condition,
                              child: Text(condition.displayName),
                            ),
                        ],
                        hint: const Text("Condition"),
                        dropdownColor: Colors.white,
                        icon: const Icon(Icons.arrow_drop_down),
                        iconSize: 36,
                        isExpanded: true,
                        underline: const SizedBox(),
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 22,
                        ),
                        value: model.condition,
                        onChanged: (selectedCondition) {
                          model.condition = selectedCondition!;
                        },
                      ),
                    ),
                  ],
                ),
              ),
              InputContainer(
                text: "Description of the Item",
                hint: "Item Description",
                controller: model.descriptionController,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Align(
                      alignment: Alignment.centerLeft,
                      child: Text(
                        "Categories",
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Wrap(
                      spacing: 5,
                      children: <Widget>[
                        for (final category in Category.values)
                          FilterChip(
                            label: Text(category.title),
                            selected: model.categories.contains(category),
                            selectedColor: const Color.fromRGBO(0, 90, 67, 1),
                            onSelected: (selected) {
                              model.setCategorySelected(
                                category: category,
                                selected: selected,
                              );
                            },
                          ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      );
}

/// Reusable InputContainer for input fields
class InputContainer extends ReactiveWidget<ProductBuilder> {
  /// Text to be entered in the input
  final String text;

  /// Hint to be entered for the input
  final String hint;

  /// Controller available in the model
  final TextEditingController controller;

  /// Constructor to set the fields
  const InputContainer({
    required this.text,
    required this.hint,
    required this.controller,
    super.key,
  });

  @override
  ProductBuilder createModel() => ProductBuilder();
  @override
  Widget build(BuildContext context, ProductBuilder model) => Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: <Widget>[
            Align(
              alignment: Alignment.centerLeft,
              child: Text(
                text,
                style:
                    const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
              ),
            ),
            TextField(
              controller: controller,
              decoration: InputDecoration(
                border: const OutlineInputBorder(),
                hintText: hint,
              ),
            ),
          ],
        ),
      );
}
// The main function is the starting point for all our Apps
// The Material app is the parent of all the widgets that we've used in our App

// import 'package:flutter/material.dart';

// enum Conditions { condition1, condition2, condition3, condition4 }

// enum ExerciseFilter { walking, running, cycling, hiking }

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
//   Set<ExerciseFilter> filters = <ExerciseFilter>{};

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
//             Padding(
//               padding: EdgeInsets.all(20),
//               child: Column(
//                 children: [
//                   Align(
//                     alignment: Alignment.centerLeft,
//                     child: Text(
//                       "Categories",
//                       style:
//                           TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
//                     ),
//                   ),
//                   Wrap(
//                     spacing: 5.0,
//                     children: <Widget>[
//                       for (final exercise in ExerciseFilter.values)
//                         FilterChip(
//                           label: Text(exercise.name),
//                           selected: filters.contains(exercise),
//                           selectedColor: Color.fromRGBO(0, 90, 67, 1),
//                           onSelected: (bool selected) {
//                             setState(
//                               () {
//                                 if (selected) {
//                                   filters.add(exercise);
//                                 } else {
//                                   filters.remove(exercise);
//                                 }
//                               },
//                             );
//                           },
//                         ),
//                     ],
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
