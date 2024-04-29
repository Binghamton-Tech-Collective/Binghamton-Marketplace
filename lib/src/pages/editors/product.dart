import "package:btc_market/src/widgets/generic/snackbar.dart";
import "package:flutter/material.dart";
import "package:flutter/services.dart";

import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";
import "package:btc_market/data.dart";

/// The Product Editor/Creator page.
class ProductEditor extends ReactiveWidget<ProductBuilder> {
  /// The [TextStyle] to use for labels throughout the page.
  static const labelStyle = TextStyle(fontSize: 20, fontWeight: FontWeight.bold);
  
  /// Id of the product to be edited
  final ProductID? id;

  /// The already-loaded product, if any.
  final Product? initialProduct;

  /// Constructor to initialize the id fo the product
  const ProductEditor({
    this.id, 
    this.initialProduct,
  });

  @override
  ProductBuilder createModel() => ProductBuilder(
    initialID: id,
    initialProduct: initialProduct,
  );

  @override
  Widget build(BuildContext context, ProductBuilder model) => Scaffold(
    appBar: AppBar(
      title: const Text("List Item"),
      actions: [
        ProfileButton(),
      ],
    ),
    body: Center(
      child: Column(
        children: [
          Expanded(
            child: ListView(
              shrinkWrap: true,
              padding: const EdgeInsets.all(20),
              children: [
                SpacedRow(
                  const Text("Profile (Required)", style: labelStyle),
                  DropdownMenu(
                    enabled: !model.isEditing,
                    onSelected: model.setProfile,
                    initialSelection: model.profile,
                    dropdownMenuEntries: [
                      for (final otherProfile in model.otherProfiles) DropdownMenuEntry(
                        value: otherProfile,
                        label: otherProfile.name,
                        leadingIcon: CircleAvatar(backgroundImage: NetworkImage(otherProfile.imageUrl)),
                      ),
                    ],
                  ),
                ),
                InputContainer(
                  text: "Name of the Item (Required)",
                  hint: "Item Name",
                  controller: model.titleController,
                ),
                const SizedBox(height: 12),
                InputContainer(
                  text: "Price of the Item (Required)",
                  hint: "Item Price",
                  prefixIcon: const Icon(Icons.attach_money),
                  controller: model.priceController,
                  formatter: FilteringTextInputFormatter.allow(RegExp(r"[\d\.]")),
                  inputType: const TextInputType.numberWithOptions(decimal: true),
                  errorText: model.priceError,
                ),
                const SizedBox(height: 12),
                const Center(
                  child: Text("Upload Photos (Atleast 1)", style: labelStyle),
                ),
                const SizedBox(height: 8),
                if (model.imageError != null) Text(
                  model.imageError!,
                  style: TextStyle(color: context.colorScheme.error),
                ),
                GridView.count(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true,
                  crossAxisCount: MediaQuery.of(context).size.width ~/ ProductWidget.minWidth,
                  mainAxisSpacing: 4,
                  crossAxisSpacing: 4,
                  children: [
                    for (final index in range(4)) Hero(
                      tag: "${model.initialProduct?.id}-image-$index",
                      child: ImageUploader(
                        imageUrl: model.imageUrls[index],
                        onTap: () => model.uploadImage(index),
                        onDelete: () => model.deleteImage(index),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                SpacedRow(
                  const Text("Condition (Required)", style: labelStyle),
                  DropdownMenu<ProductCondition>(
                    initialSelection: model.condition,
                    hintText: "Condition",
                    onSelected: model.setCondition,
                    enableSearch: false,
                    dropdownMenuEntries: [
                      for (final condition in ProductCondition.values) DropdownMenuEntry(
                        value: condition,
                        label: condition.displayName,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 12),
                InputContainer(
                  text: "Description of the Item (Required)",
                  hint: "Item Description",
                  controller: model.descriptionController,
                ),
                const SizedBox(height: 12),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: Text(
                    "Categories (Optional)",
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                const SizedBox(height: 8),
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: <Widget>[
                    for (final category in Category.values) CategoryFilterChip(
                      category: category,
                      isSelected: model.categories.contains(category),
                      onSelected: (selected) => model.setCategorySelected(category: category, selected: selected),
                    ),
                  ],
                ),
                const SizedBox(height: 12),
                if (model.isSaving) const LinearProgressIndicator(),
                if (model.saveError != null) Text(
                  model.saveError!,
                  style: TextStyle(color: context.colorScheme.error),
                ),
                const Divider(),
                Text(
                  "By listing a product, you agree to our terms and conditions. This includes adhering to all applicable laws and regulations. Products that violate these terms, including the sale of illegal items, will be removed, and your account may be subject to permanent suspension and potential reporting to relevant authorities, including the university.",
                  style: context.textTheme.bodyMedium,
                ),
                CheckboxListTile.adaptive(
                  value: model.agreedToTerms, 
                  onChanged: model.updateTerms,
                  controlAffinity: ListTileControlAffinity.leading,
                  title: const Text(
                    "I understand and agree to the terms", 
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
          ),
          ButtonBar(
            children: [
              if (model.isEditing) FilledButton(
                style: FilledButton.styleFrom(backgroundColor: Colors.red),
                onPressed: () => delete(context, model),
                child: const Text("Delete product"),
              ),
              FilledButton(
                onPressed: model.isReady ? () {
                  model.save();
                  ScaffoldMessenger.of(context).showSnackBar(CustomSnackBar(text: "Success", context: context),);
                } : null,
                child: const Text("Save product"),
              ),
            ],
          ),
        ],
      ),
    ),
  );

  /// Opens a dialog to confirm deleting the product.
  Future<void> delete(BuildContext context, ProductBuilder model) => showDialog<void>(
    context: context,
    builder:(context) => AlertDialog(
      title: const Text("Confirm delete"),
      content: const Text("Are you sure you want to delete this product? This will also delete any associated reviews.\n\nThis action is permanent and cannot be undone."),
      actions: [
        TextButton(
          child: const Text("Cancel"),
          onPressed: () => Navigator.of(context).pop(),
        ),
        FilledButton(
          style: FilledButton.styleFrom(backgroundColor: Colors.red),
          onPressed: () async {
            await model.deleteProduct();
            if (!context.mounted) return;
            Navigator.of(context).pop();
          }, 
          child: const Text("Delete"),
        ),
      ],
    ),
  );
}
