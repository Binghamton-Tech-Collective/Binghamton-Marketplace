import "package:btc_market/main.dart";
import "package:flutter/material.dart";

/// SearchBar widget
class SearchBarWidget extends StatelessWidget {
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
