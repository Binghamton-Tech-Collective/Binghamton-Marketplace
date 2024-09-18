import "dart:typed_data";
import "package:file_picker/file_picker.dart";
import "package:firebase_storage/firebase_storage.dart";

import "package:btc_market/data.dart";
import "service.dart";

export "package:firebase_storage/firebase_storage.dart" show Reference;

/// A service to use CRUD operations on Google Cloud Storage for Firebase.
class CloudStorageService extends Service {
  late final Reference _root = FirebaseStorage.instance.ref();
  
  @override
  Future<void> init() async {}

  @override
  Future<void> dispose() async {}

  /// Returns a file picked by the user. 
  Future<Uint8List?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: "Pick an image",
      type: FileType.image,
      withData: true,
    );
    if (result == null) return null;
    return result.files.firstOrNull?.bytes;
  }

  /// Uploads data to a file in Firebase Storage.
  Future<String?> uploadFile(Uint8List data, Reference reference) async {
    try {
      await reference.putData(data);
      final downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      return null;
    }
  }

  /// Deletes the file at the given path.
  Future<void> deleteFile(String path) async {
    try{
      await _root.child(path).delete();
    } on FirebaseException catch(error) {
      if(error.code != "object-not-found") {
        rethrow;
      }
    }
  }

  /// Deletes all data associated with a seller profile.
  Future<void> deleteSellerProfile(SellerID id) => _root.child("sellers/$id/").deleteFolder();
  
  /// Deletes all data associated with a product.
  Future<void> deleteProduct(ProductID id) => _root.child("products/$id/").deleteFolder();

  /// Gets the image path for [SellerProfile.imageUrl].
  Reference getSellerImagePath(SellerID id) => _root.child("sellers/$id/profile_pic");

  /// Gets the image path for [Product.imageUrls].
  Reference getProductImage(ProductID id, int index) => _root.child("products/$id/$index");

  /// Gets the image path for [UserProfile.imageUrl].
  Reference getUserImagePath(UserID id) => _root.child("users/$id/profile_pic");
}

extension on Reference {
  Future<void> deleteFolder() async {
    final result = await listAll(); 
    for (final file in result.items) {
      await file.delete();
    }
  }
}
