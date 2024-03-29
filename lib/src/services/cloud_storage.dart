import "dart:typed_data";
import "package:file_picker/file_picker.dart";
import "package:firebase_storage/firebase_storage.dart";

import "package:btc_market/data.dart";
import "service.dart";

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
  Future<String?> uploadFile(Uint8List data, String path) async {
    final reference = _root.child(path);
    try {
      await reference.putData(data);
      final downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      return null;
    }
  }

  /// Deletes the file at the given path.
  Future<void> deleteFile(String path) => _root.child(path).delete();

  /// Returns the path of the seller's profile picture.
  String getSellerImagePath(SellerID id) => "sellers/$id/profile_pic";

  /// Returns the path of the seller's profile picture.
  String getProductImage(ProductID id, int index) => "products/$id/$index";
}
