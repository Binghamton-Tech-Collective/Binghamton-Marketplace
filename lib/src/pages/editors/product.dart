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
              //             Enter the image upload widget here
              Padding(
                padding: const EdgeInsets.all(20),
                child: Column(
                  children: [
                    const Text(
                      "Upload Photos",
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                    GestureDetector(
                      onTap: () async {
                        try {
                          await model.uploadImage(0);
                          
                        }catch(error) {
                          //TODO: Check why we're not able to access the errorText variable
                          // errorText = "Error uploading the images!";
                        }
                      },
                      child: Container(
                        color: Colors.redAccent,
                        height: 250,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("clicked card 1");
                                  },
                                  child: const ImageUploader(
                                    color: Colors.deepPurpleAccent,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("clicked card 2");
                                  },
                                  child: const ImageUploader(
                                    color: Colors.yellowAccent,
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                GestureDetector(
                                  onTap: () {
                                    print("clicked card 3");
                                  },
                                  child: const ImageUploader(
                                    color: Colors.blueAccent,
                                  ),
                                ),
                                GestureDetector(
                                  onTap: () {
                                    print("clicked card 4");
                                  },
                                  child: const ImageUploader(
                                    color: Colors.greenAccent,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
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

/// Reusable image uploader widget

class ImageUploader extends ReactiveWidget<ProductBuilder> {
  /// Background color of the card
  final Color color;

  /// The index of the widget to fetch the image from
  final int? index;

  /// Link to the image
  final String? imageURL;

  /// Constructor to initialize the widget
  const ImageUploader({required this.color, this.imageURL, this.index});

  @override
  ProductBuilder createModel() => ProductBuilder();

  @override
  Widget build(BuildContext context, ProductBuilder model) => Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(10),
        ),
        child: Center(
          child: model.imageUrls != null &&
                  index != null &&
                  index! >= 0 &&
                  model.imageUrls!.length > index!
              ? Image.network(
                  model.imageUrls[index!],
                  fit: BoxFit.cover,
                )
              : const Text(
                  "Upload an Image!",
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
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
//             Enter the image upload widget here
            // Padding(
            //     padding: EdgeInsets.all(20),
            //     child: Column(children: [
            //       Text(
            //         "Upload Photos",
            //         style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            //       ),
            //       GestureDetector(
            //         onTap: () async {
            //           print("clicked");
                      // Call the uploadImage function from the model
                    },
//                     child: Container(
//                       color: Colors.redAccent,
//                       height: 250,
//                       child: Column(
//                         mainAxisAlignment: MainAxisAlignment.spaceAround,
//                         children: [
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   print("clicked card 1");
//                                 },
//                                 child: ReusableCard(
//                                   color: Colors.deepPurpleAccent,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   print("clicked card 2");
//                                 },
//                                 child: ReusableCard(
//                                   color: Colors.yellowAccent,
//                                 ),
//                               ),
//                             ],
//                           ),
//                           Row(
//                             mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                             children: [
//                               GestureDetector(
//                                 onTap: () {
//                                   print("clicked card 3");
//                                 },
//                                 child: ReusableCard(
//                                   color: Colors.blueAccent,
//                                 ),
//                               ),
//                               GestureDetector(
//                                 onTap: () {
//                                   print("clicked card 4");
//                                 },
//                                 child: ReusableCard(
//                                   color: Colors.greenAccent,
//                                 ),
//                               ),
//                             ],
//                           ),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ],),),
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
//                     padding: EdgeInsets.all(6.0),
//                     decoration: BoxDecoration(
//                       border: Border.all(color: Colors.grey, width: 1),
//                       borderRadius: BorderRadius.circular(15),
//                     ),
//                     child: DropdownButton(
//                       items: listItems.map(
//                         (valueItem) {
//                           return DropdownMenuItem(
//                             value: valueItem,
//                             child: Text(valueItem),
//                           );
//                         },
//                       ).toList(),
//                       hint: Text("Condition"),
//                       dropdownColor: Colors.white,
//                       icon: Icon(Icons.arrow_drop_down),
//                       iconSize: 36,
//                       isExpanded: true,
//                       underline: SizedBox(),
//                       style: TextStyle(
//                         color: Colors.black,
//                         fontSize: 22,
//                       ),
//                       value: valueChoose,
//                       onChanged: (newValue) {
//                         setState(
//                           () {
//                             valueChoose = newValue;
//                           },
//                         );
//                       },
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

// @immutable
// class ReusableCard extends StatelessWidget {
//   final Color color;
//   final String? imageURL;
//   const ReusableCard({this.imageURL, required this.color});

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       width: 100.0,
//       height: 100.0,
// //       margin: const EdgeInsets.all(15.0),
//       decoration: BoxDecoration(
//         color: color,
//         borderRadius: BorderRadius.circular(10.0),
//       ),
//       child: Center(
//           child: this.imageURL != null
//               ? Image.network(
//                   imageURL!,
//                   fit: BoxFit.cover,
//                 )
//               : Text(
//                   "Upload an Image!",
//                   style: TextStyle(
//                     color: Colors.white,
//                   ),
//                 ),),
//     );
//   }
// }
