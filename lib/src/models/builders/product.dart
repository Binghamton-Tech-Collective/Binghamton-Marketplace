// import "package:btc_market/models.dart";
// import "package:btc_market/services.dart";
// import "package:flutter/material.dart";
// import "package:btc_market/data.dart";

// extension on String {
//   String? get nullIfEmpty => isEmpty ? null : this;
// }

// /// Class to create view model for sign up page for seller
// class ProductBuilder extends BuilderModel<Product> {
//   late final ProductID productID;
//   late final UserID userID;
//   final titleController = TextEditingController();
//   final descriptionController = TextEditingController();
//   final priceController = TextEditingController();
//   late final Set<Category> categories;
//   final quantityController = TextEditingController();
//   List<String>? imageUrls;
//   late final ProductCondition condition;
//   late final DateTime dateListed;

//   /// Fetching the seller ID.
//   late final SellerID sellerID;

//   /// Fetching the email address of the seller
//   String get email => services.auth.user!.email!;

//   /// URL of the profile image
//   String? imageUrl;

//   @override
//   Future<void> init() async {
//     isLoading = true;
//     sellerID = services.database.sellers.newID;
//     productID = services.database.products.;
//     userID = models.user.userProfile!.id;
//     isLoading = false;
//   }

//   /// Function to build the profile from the input provided by the user
//   @override
//   SellerProfile build() => SellerProfile(
//         id: sellerID,
//         name: nameController.text,
//         userID: userID,
//         imageUrl: imageUrl!,
//         bio: bioController.text,
//         contact: ContactInfo(
//           email: email,
//           phoneNumber: phoneNumberController.text.nullIfEmpty,
//           tikTokUsername: tikTokController.text.nullIfEmpty,
//           instagramHandle: instagramController.text.nullIfEmpty,
//           twitterUsername: twitterController.text.nullIfEmpty,
//           linkedInUsername: linkedinController.text.nullIfEmpty,
//         ),
//       );

//   @override
//   bool get isReady =>
//       nameController.text.isNotEmpty &&
//       bioController.text.isNotEmpty &&
//       sellerID.toString().isNotEmpty &&
//       userID.toString().isNotEmpty &&
//       imageUrl != null &&
//       email.isNotEmpty;

//   /// Upload the image provided by the user and set the imageURL to the link obtained
//   Future<void> uploadImage() async {
//     // Pick a file, upload to Firebase Storage, then set [imageUrl]
//     /**
//      * Package: file_picker => This function should be called here
//      * The functions will be in cloud_storage.dart and will be asynchronous
//      * Have a look at PlatformFile datatype
//      */

//     // final file = await services.cloud_storage.pickFile();
//     // if (file == null) return;
//     // final bytes = file.bytes!;
//     // imageUrl = await services.cloud_storage
//     //     .uploadFile(bytes, "sellers/$sellerID/avatar");
//     // notifyListeners();
//   }

//   /// Saving the profile to Cloud Firestore
//   Future<void> save() async {
//     // Save the result of build() to Cloud Firestore.
//     isLoading = true;
//     final profile = build();
//     await services.database.saveSellerProfile(profile);
//     isLoading = false;
//     notifyListeners();
//   }
// }
