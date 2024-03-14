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
  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result == null) return null;
    if (result.files.isEmpty) return null;
    return result.files.first;
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

  /// Returns the path of the seller's profile picture.
  String getSellerProfilePath(SellerID id) => "sellers/$id/profile_pic";
}
