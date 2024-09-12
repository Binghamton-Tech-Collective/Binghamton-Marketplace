import "package:btc_market/data.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// A selectable [FilterChip] for a [Category].
class CategoryFilterChip extends StatelessWidget {
  /// The category to show.
  final Category category;
  
  /// Whether the category is selected.
  final bool isSelected;

  /// A callback when the user selects or deselects the category.
  final ValueChanged<bool> onSelected;
  
  /// Creates a [FilterChip] for the given category. 
  const CategoryFilterChip({
    required this.category,
    required this.isSelected,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) => FilterChip(
    avatar: CircleAvatar(backgroundImage: AssetImage(category.imagePath)),
    label: Text(category.title),
    tooltip: category.title,
    selected: isSelected,
    selectedColor: context.colorScheme.primary,
    onSelected: onSelected,
    showCheckmark: false,
    labelStyle: TextStyle(color: isSelected
      ? context.colorScheme.onPrimary
      : context.colorScheme.onSurface,
    ),
  );
}

/// A read-only [Chip] for a [Category].
class CategoryChip extends StatelessWidget {
  /// The category to show.
  final Category category;
  
  /// Creates a non-interactive [Chip] for the given category. 
  const CategoryChip(this.category);

  @override
  Widget build(BuildContext context) => Chip(
    avatar: CircleAvatar(backgroundImage: AssetImage(category.imagePath)),
    label: Text(category.title),
  );
}
