import "package:flutter/material.dart";
import "package:flutter_rating_bar/flutter_rating_bar.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/widgets.dart";

class FilterOption extends StatelessWidget {
  final String name;
  final Widget child;
  const FilterOption({
    required this.name,
    required this.child,
  });

  @override
  Widget build(BuildContext context) => Row(
    mainAxisAlignment: MainAxisAlignment.end,
    children: [
      const SizedBox(width: 16),
      Text(
        name,
        style: context.textTheme.titleMedium,
      ),
      const Spacer(),
      Expanded(
        flex: 3, 
        child: Align(
          alignment: Alignment.centerRight,
          child: child,
        ),
      ),
      const SizedBox(width: 16),
    ],
  );
}

class ProductFiltersEditor extends ReusableReactiveWidget<ProductFiltersBuilder> {
  const ProductFiltersEditor(super.model);

  @override
  Widget build(BuildContext context, ProductFiltersBuilder model) => Column(
    mainAxisSize: MainAxisSize.min,
    children: [
      const SizedBox(height: 12),
      FilterOption(
        name: "Sort order",
        child: DropdownMenu<ProductSortOrder>(
          menuStyle: MenuStyle(
            shape: MaterialStatePropertyAll(
              ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(20),
              ),
            ),
          ),
          initialSelection: model.sortOrder,
          hintText: "Sort by...",
          onSelected: model.updateSortOrder,
          dropdownMenuEntries: [
            for (final sortOrder in ProductSortOrder.values) DropdownMenuEntry(
              value: sortOrder,
              label: sortOrder.displayName,
            ),
          ],
        ),
      ),
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

  List<Widget> buildBody(BuildContext context, ProductFiltersBuilder model) => switch (model.sortOrder) {
    ProductSortOrder.byNew || ProductSortOrder.byOld => [],
    ProductSortOrder.byPriceAscending || ProductSortOrder.byPriceDescending => [
      const SizedBox(height: 12),
      FilterOption(
        name: "Minimum price",
        child: TextField(
          controller: model.minPriceController,
          decoration: InputDecoration(
            prefixText: r"$",
            border: const OutlineInputBorder(),
            hintText: "Min price",
            errorText: model.minPriceError,
            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
        ),
      ),
      const SizedBox(height: 12),
      FilterOption(
        name: "Maximum price",
        child: TextField(
          controller: model.maxPriceController,
          decoration: InputDecoration(
            prefixText: r"$",
            border: const OutlineInputBorder(),
            hintText: "Max price",
            errorText: model.maxPriceError,
            focusedErrorBorder: const OutlineInputBorder(borderSide: BorderSide(color: Colors.red)),
          ),
        ),
      ),
    ],
    ProductSortOrder.byRating => [
      const SizedBox(height: 12),
      FilterOption(
        name: "Minimum Rating", 
        child: RatingBar(
          initialRating: (model.minRating as double?) ?? 0,
          onRatingUpdate: model.updateMinRating,
          ratingWidget: RatingWidget(
            full: const Icon(Icons.star),
            half: const Icon(Icons.star_half),
            empty: const Icon(Icons.star_border),
          ),
        ),
      ),
    ],
  };
}
