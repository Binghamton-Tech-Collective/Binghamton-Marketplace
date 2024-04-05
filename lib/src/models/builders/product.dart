import "package:flutter/material.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:btc_market/pages.dart";

/// Class to create view model for sign up page for seller
class ProductBuilder extends BuilderModel<Product> {
  /// Id of the product if we're editing it
  final ProductID? initialID;

  /// Constructor to initialize the initialID
  ProductBuilder({this.initialID});

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

  /// The seller profile that will own the account.
  SellerProfile? profile;

  /// The error when uploading the image, if any.
  String? imageError;

  /// An error when validating the price, if any.
  String? priceError;

  /// All the seller profiles this user owns.
  List<SellerProfile> get otherProfiles => models.user.sellerProfiles;

  /// Sets the profile this product will be owned by.
  void setProfile(SellerProfile? input) {
    if (input == null) return;
    profile = input;
    notifyListeners();
  }

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
    if (initialID == null) {
      productID = services.database.products.newID;
      return;
    } else {
      await prefill();
    }
    priceController.addListener(_validatePrice);
    titleController.addListener(notifyListeners);
    descriptionController.addListener(notifyListeners);
  }

  /// Prefills all the fields on this page with the [initialID].
  Future<void> prefill() async {
    // Load the product
    final Product? product;
    try {
      isLoading = true;
      product = await services.database.getProduct(initialID!);
      isLoading = false;
    } catch (error) {
      errorText = "Could not load a product with ID: $initialID";
      return;
    }
    // Check if the product exists
    if (product == null) {
      errorText = "No product exists with ID: $initialID";
      return;
    }
    // Prefill all the fields
    productID = product.id;
    final sellerID = product.sellerID;
    profile = await services.database.getSellerProfile(sellerID);
    titleController.text = product.title;
    descriptionController.text = product.description;
    priceController.text = product.price.toString();
    quantityController.text = product.quantity.toString();
    categories.addAll(product.categories);
    condition = product.condition;
    for (var index = 0; index < imageUrls.length; index++) {
      if (index >= product.imageUrls.length) {
        imageUrls[index] = null;
      } else {
        imageUrls[index] = product.imageUrls[index];
      }
    }
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
    sellerID: profile!.id,
    userID: models.user.userProfile!.id,
    title: titleController.text,
    description: descriptionController.text,
    price: double.parse(priceController.text),
    quantity: 1,
    imageUrls: [
      for (final url in imageUrls)
        if (url != null) url,
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
    // quantityController.text.isNotEmpty &&
    imageUrls.any((url) => url != null) &&
    condition != null &&
    profile != null &&
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
    await services.cloudStorage.deleteFile(imageUrls[index]!);
    imageUrls[index] = null;
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
