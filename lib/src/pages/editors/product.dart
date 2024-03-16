import "package:flutter/material.dart";

import "package:btc_market/widgets.dart";
import "package:btc_market/models.dart";
import "package:btc_market/data.dart";
import "package:flutter/services.dart";

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
    body: !model.isSeller
      ? const Text("Not a seller!")
      : Center(
          child: ListView(
            padding: const EdgeInsets.all(20),
            children: [
              InputContainer(
                text: "Name of the Item",
                hint: "Item Name",
                controller: model.titleController,
              ),
              const SizedBox(height: 12),
              InputContainer(
                text: "Price of the Item",
                hint: "Item Price",
                controller: model.priceController,
                formatter: FilteringTextInputFormatter.allow(RegExp(r"[\d\.]")),
                inputType: const TextInputType.numberWithOptions(decimal: true),
                errorText: model.priceError,
              ),
              const SizedBox(height: 12),
              const Center(
                child: Text(
                  "Upload Photos",
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                ),
              ),
              const SizedBox(height: 8),
              if (model.imageError != null) Text(
                model.imageError!,
                style: TextStyle(color: context.colorScheme.error),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => model.uploadImage(0),
                        child: 
                        ImageUploader(
                          imageUrl: model.imageUrls[0],
                          onDelete: () => model.deleteImage(0),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => model.uploadImage(1),
                        child: ImageUploader(
                          imageUrl: model.imageUrls[1],
                          onDelete: () => model.deleteImage(1),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      GestureDetector(
                        onTap: () => model.uploadImage(2),
                        child: ImageUploader(
                          imageUrl: model.imageUrls[2],
                          onDelete: () => model.deleteImage(2),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => model.uploadImage(3),
                        child: ImageUploader(
                          imageUrl: model.imageUrls[3],
                          onDelete: () => model.deleteImage(3),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
              const SizedBox(height: 12),
              Row(
                children: [
                  const Text(
                    "Condition",
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  const Spacer(),
                  DropdownMenu<ProductCondition>(
                    dropdownMenuEntries: [
                      for (final condition in ProductCondition.values)
                        DropdownMenuEntry(
                          value: condition,
                          label: condition.displayName,
                        ),
                    ],
                    hintText: "Condition",
                    onSelected: model.setCondition,
                    enableSearch: false,
                  ),
                ],
              ),
              const SizedBox(height: 12),
              InputContainer(
                text: "Description of the Item",
                hint: "Item Description",
                controller: model.descriptionController,
              ),
              const SizedBox(height: 12),
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
              const SizedBox(height: 8),
              Wrap(
                spacing: 5,
                children: <Widget>[
                  for (final category in Category.values) FilterChip(
                    label: Text(category.title),
                    selected: model.categories.contains(category),
                    selectedColor: const Color.fromRGBO(0, 90, 67, 1),
                    onSelected: (selected) => model.setCategorySelected(
                      category: category,
                      selected: selected,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              if (model.isSaving) const LinearProgressIndicator(),
              SizedBox(
                height: 48,
                width: double.infinity,
                child: FilledButton(
                  onPressed: model.isReady ? model.save : null,
                  child: const Text("Save product"),
                ),
              ),
              if (model.saveError != null) Text(
                model.saveError!,
                style: TextStyle(color: context.colorScheme.error),
              ),
            ],
          ),
        ),
  );
}

/// Reusable InputContainer for input fields
class InputContainer extends StatelessWidget {
  /// Text to be entered in the input
  final String text;

  /// Hint to be entered for the input
  final String hint;

  /// Controller available in the model
  final TextEditingController controller;

  /// The formatter for this text field, if any.
  final TextInputFormatter? formatter;

  /// The keyboard type for this input, if not the default.
  final TextInputType? inputType;

  /// The error with this input, if any.
  final String? errorText;

  /// Constructor to set the fields
  const InputContainer({
    required this.text,
    required this.hint,
    required this.controller,
    this.formatter,
    this.inputType,
    this.errorText,
    super.key,
  });

  @override
  Widget build(BuildContext context) => Column(
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
        inputFormatters: [
          if (formatter != null) formatter!,
        ],
        keyboardType: inputType,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          hintText: hint,
          errorText: errorText,
        ),
      ),
    ],
  );
}

/// Reusable image uploader widget
class ImageUploader extends StatelessWidget {
  /// Link to the image
  final String? imageUrl;

  /// A callback to run when the user presses "clear"
  final VoidCallback onDelete;
  
  /// Constructor to initialize the widget
  const ImageUploader({required this.imageUrl, required this.onDelete});

  @override
  Widget build(BuildContext context) => Column(
    children: [
      Container(
        width: 100,
        height: 100,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Card(
          child: Center(
            child: imageUrl == null
              ? const Text(
                "Upload an Image!",
                textAlign: TextAlign.center,
              ) : Image.network(
                imageUrl!,
                fit: BoxFit.cover,
              ),
          ),
        ),
      ),
      if (imageUrl != null) ...[
        const SizedBox(height: 8),
        TextButton(
          onPressed: onDelete,
          child: const Text("Clear"),
        ),
      ],
    ],
  );
}
