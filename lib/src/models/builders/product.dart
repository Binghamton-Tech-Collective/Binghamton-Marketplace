import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:flutter/material.dart";
import "package:btc_market/data.dart";

/// Class to create view model for sign up page for seller
class ProductBuilder extends BuilderModel<Product> {
  /// Unique product ID of the product
  late final ProductID productID;

  /// Title controller of the product
  final titleController = TextEditingController();

  /// Description controller of the product
  final descriptionController = TextEditingController();

  /// Price controller of the product
  final priceController = TextEditingController();

  /// Categories that the product belongs to
  late final Set<Category> categories;

  /// Quantity controller of the product
  final quantityController = TextEditingController();

  /// List of URL's of the images for the product
  List<String?> imageUrls = [null, null, null, null];

  /// Condition of the product
  late final ProductCondition condition;

  /// Date and time the product was added
  late final DateTime dateListed;

  /// Seller ID of the seller adding products
  late final SellerID sellerID;

  /// To add the selected category to the set

  void setCategorySelected(
      {required Category category, required bool selected}) {
    if (selected) {
      categories.add(category);
    } else {
      categories.remove(category);
    }
    isLoading = false;
    notifyListeners();
  }

  /// Setting the condition of the product
  void setCondition(ProductCondition condition) {
    isLoading = true;
    this.condition = condition;
    isLoading = false;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    isLoading = true;
    sellerID = models.user.sellerProfile!.id;
    productID = services.database.products.newID;
    isLoading = false;
  }

  /// Function to build the profile from the input provided by the user
  @override
  Product build() => Product(
        id: productID,
        sellerID: sellerID,
        title: titleController.text,
        description: descriptionController.text,
        price: double.parse(priceController.text),
        quantity: int.parse(priceController.text),
        imageUrls: List<String>.from(imageUrls),
        categories: categories,
        condition: condition,
        dateListed: DateTime.now(),
      );

  @override
  bool get isReady =>
      titleController.text.isNotEmpty &&
      descriptionController.text.isNotEmpty &&
      priceController.text.isNotEmpty &&
      quantityController.text.isNotEmpty &&
      categories.isNotEmpty &&
      imageUrls.any((url) => url != null) &&
      condition.toString().isNotEmpty &&
      sellerID.toString().isNotEmpty;

  /// Upload the image provided by the user and set the imageURL to the link obtained
  Future<void> uploadImage(int index) async {
    // Pick a file, upload to Firebase Storage, then set [imageUrl]
    /**
     * Will have to use the logic for multi file picker.
     */
  }

  /// Saving the profile to Cloud Firestore
  Future<void> save() async {
    isLoading = true;
    final product = build();
    await services.database.saveProduct(product);
    isLoading = false;
    notifyListeners();
  }
}
