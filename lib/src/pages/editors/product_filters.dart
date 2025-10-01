import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

/// A widget to customize [ProductFilters] based on [ProductFiltersBuilder].
class ProductFiltersEditor extends ReusableReactiveWidget<ProductFiltersBuilder> {
  /// Builds a widget to customize [ProductFilters] and [ProductSortOrder].
  const ProductFiltersEditor(super.model);

  @override
  Widget build(BuildContext context, ProductFiltersBuilder model) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 12),
      LabelledOption(
        name: "Sort order",
        child: DropdownMenu<ProductSortOrder>(
          menuStyle: MenuStyle(
            shape: WidgetStatePropertyAll(
              ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          initialSelection: model.sortOrder,
          hintText: "Sort by...",
          onSelected: model.updateSortOrder,
          dropdownMenuEntries: [
            for (final sortOrder in ProductSortOrder.values)
              if (sortOrder != ProductSortOrder.byRating) DropdownMenuEntry(
                value: sortOrder,
                label: sortOrder.displayName,
              ),
          ],
        ),
      ),
      const SizedBox(height: 12),
      ...buildBody(context, model),
      const Spacer(),
      Row(
        children: [
          const SizedBox(width: 4),
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text("Close"),
          ),
          const Spacer(),
          TextButton(
            onPressed: model.clear,
            child: const Text("Reset filters"),
          ),
          const SizedBox(width: 12),
          FilledButton(
            onPressed: !model.isReady ? null : () {
              model.search();
              Navigator.of(context).pop();
            },
            child: const Text("Apply filters"),
          ),
          const SizedBox(width: 4),
        ],
      ),
    ],
  );

  /// A widget to pick the minimum price in a filter.
  Widget minPrice(BuildContext context, ProductFiltersBuilder model) => LabelledOption(
    name: "Minimum price",
    child: TextField(
      controller: model.minPriceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.attach_money),
        border: const OutlineInputBorder(),
        hintText: "Min price",
        errorText: model.minPriceError,
        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
    ),
  );

  /// A widget to pick the maximum price in a filter.
  Widget maxPrice(BuildContext context, ProductFiltersBuilder model) => LabelledOption(
    name: "Maximum price",
    child: TextField(
      controller: model.maxPriceController,
      keyboardType: TextInputType.number,
      decoration: InputDecoration(
        prefixIcon: const Icon(Icons.attach_money),
        border: const OutlineInputBorder(),
        hintText: "Max price",
        errorText: model.maxPriceError,
        focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
      ),
    ),
  );

  /// A widget to pick the minimum rating in a filter.
  Widget minRating(BuildContext context, ProductFiltersBuilder model) => LabelledOption(
    name: "Minimum Rating",
    child: RatingBar(
      initialRating: model.minRating?.toDouble() ?? 0,
      onRatingUpdate: model.updateMinRating,
      ratingWidget: RatingWidget(
        full: const Icon(Icons.star),
        half: const Icon(Icons.star_half),
        empty: const Icon(Icons.star_border),
      ),
    ),
  );

  /// Builds the available filter options based on [ProductFiltersBuilder.sortOrder].
  List<Widget> buildBody(BuildContext context, ProductFiltersBuilder model) => [
    const SizedBox(height: 12),
    minPrice(context, model),
    const SizedBox(height: 12),
    maxPrice(context, model),
    // ===== Uncomment these when we support ratings =====
    // const SizedBox(height: 12),
    // minRating(context, model),
  ];
}
