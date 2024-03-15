import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:btc_market/pages.dart";

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
  final Set<Category> categories = {};

  /// Quantity controller of the product
  final quantityController = TextEditingController();

  /// List of URL's of the images for the product
  List<String?> imageUrls = [null, null, null, null];

  /// Condition of the product
  ProductCondition? condition;

  /// Date and time the product was added
  late final DateTime dateListed;

  /// Seller ID of the seller adding products
  late final SellerID? sellerID;

  /// True if the user has any seller profiles.
  bool get isSeller => sellerID != null;

  /// The error when uploading the image, if any.
  String? imageError;

  /// An error when validating the price, if any.
  String? priceError;

  /// To add the selected category to the set
  void setCategorySelected({required Category category, required bool selected}) {
    if (selected) {
      categories.add(category);
    } else {
      categories.remove(category);
    }
    notifyListeners();
  }

  /// Setting the condition of the product
  void setCondition(ProductCondition? input) {
    if (input == null) return;
    condition = input;
    notifyListeners();
  }

  @override
  Future<void> init() async {
    isLoading = true;
    sellerID = models.user.sellerProfiles.firstOrNull?.id;
    productID = services.database.products.newID;
    priceController.addListener(_validatePrice);
    titleController.addListener(notifyListeners);
    descriptionController.addListener(notifyListeners);
    isLoading = false;
  }

  void _validatePrice() {
    priceError = null;
    if (priceController.text.isEmpty) return;
    final result = double.tryParse(priceController.text);
    if (result == null) {
      priceError = "Invalid price";
    } else if (result > 100000) {
      priceError = r"No purchases above $100K";
    }
    notifyListeners();
  }

  /// Function to build the profile from the input provided by the user
  @override
  Product build() => Product(
    id: productID,
    sellerID: sellerID!,
    userID: models.user.userProfile!.id,
    title: titleController.text,
    description: descriptionController.text,
    price: double.parse(priceController.text),
    // TODO: Add quantity here
    quantity: 1,
    imageUrls: [
      for (final url in imageUrls)
        if (url != null)
          url,
    ],
    categories: categories,
    condition: condition!,
    dateListed: DateTime.now(),
  );

  @override
  bool get isReady =>  
    titleController.text.isNotEmpty &&
    descriptionController.text.isNotEmpty &&
    priceController.text.isNotEmpty &&
    priceError == null &&
    // TODO: Add quantity
    // quantityController.text.isNotEmpty &&
    imageUrls.any((url) => url != null) &&
    condition != null &&
    sellerID != null &&
    !isSaving;

  /// Upload the image provided by the user and set the imageURL to the link obtained
  Future<void> uploadImage(int index) async {
    imageError = null;
    final file = await services.cloudStorage.pickImage();
    if (file == null) return;
    final filename = services.cloudStorage.getProductImage(productID, index);
    final url = await services.cloudStorage.uploadFile(file, filename);
    if (url == null) imageError = "Could not upload image";
    imageUrls[index] = url;
    notifyListeners();
  }

  /// Deletes the image at the given index.
  Future<void> deleteImage(int index) async {
    imageUrls[index] = null;
    final filename = services.cloudStorage.getProductImage(productID, index);
    await services.cloudStorage.deleteFile(filename);
    notifyListeners();
  }

  /// Whether we are uploading the product.
  bool isSaving = false;
  /// The error while saving the product, if any.
  String? saveError;
  /// Saving the profile to Cloud Firestore
  Future<void> save() async {
    isSaving = true;
    saveError = null;
    final product = build();
    try {
      await services.database.saveProduct(product);
      router.go("/products/$productID");
    } catch (error) {
      saveError = "There was an error saving your product";
      rethrow;
    }
    isSaving = false;
    notifyListeners();
  }
}
