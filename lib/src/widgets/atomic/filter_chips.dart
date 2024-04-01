// ignore_for_file: sort_child_properties_last, prefer_const_constructors

import "package:btc_market/data.dart";
import "package:btc_market/main.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";
import "package:flutter/widgets.dart";

import "package:go_router/go_router.dart";

// Reusable widget 

class FilterChips extends StatefulWidget {
  FilterChips({
    required this.displayText,
    required this.imgPath,
    this.isSelected = false,
    required this.onDelete,
    required this.onTap,
    super.key
    });

  String displayText;
  bool isSelected;
  Image imgPath;
  VoidCallback onTap;
  VoidCallback onDelete;

  @override
  _FilterChipState createState() => _FilterChipState();
}

class _FilterChipState extends State<FilterChips> {

  @override
  // ignore: prefer_const_constructors, prefer_expression_function_bodies
  Widget build(BuildContext context) {
    return Center(
      child: FilterChip(
        label: Text(displayText),
        onSelected: (bool value){
          setState((){
            isSelected = !isSelected;
        });
      }
      ,),
    ); 
  }
  
}
