import "package:flutter/foundation.dart";

import "types.dart";

@immutable

/// The class category is used to place the products in one of the Category bucket
class Category {
  /// Stores the unique ID for this category
  final CategoryID categoryID;

  /// Stores the name of the category
  final String title;

  /// Stores a brief description for the category
  final String description;

  /// Stores the link of the thumbnail for this category
  final String imagePath;

  /// Constructor to initialize the instances of Category class

  const Category({
    required this.categoryID,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  @override
  int get hashCode => categoryID.hashCode;

  @override
  bool operator ==(Object other) =>
      other is Category && other.categoryID == categoryID;
}
