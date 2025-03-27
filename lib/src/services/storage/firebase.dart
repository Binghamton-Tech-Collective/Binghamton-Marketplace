import "package:btc_market/data.dart";
import "package:firebase_storage/firebase_storage.dart";

import "interface.dart";

extension on Reference {
  Future<void> deleteFolder() async {
    final result = await listAll();
    for (final file in result.items) {
      await file.delete();
    }
  }
}

/// An implementation of [FilesService] with Firebase.
class CloudStorageService extends FilesService {
  late final Reference _root = FirebaseStorage.instance.ref();

  @override
  Future<void> init() async {}

  @override
  Future<String?> uploadFile(Uint8List data, Reference reference) async {
    try {
      await reference.putData(data);
      final downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      return null;
    }
  }

  @override
  Future<void> deleteFile(String path) async {
    try{
      await _root.child(path).delete();
    } on FirebaseException catch(error) {
      if(error.code != "object-not-found") {
        rethrow;
      }
    }
  }

  @override
  Future<void> deleteSellerProfile(SellerID id) => _root.child("sellers/$id/").deleteFolder();
  @override
  Future<void> deleteProduct(ProductID id) => _root.child("products/$id/").deleteFolder();
  @override
  Reference getSellerImagePath(SellerID id) => _root.child("sellers/$id/profile_pic");
  @override
  Reference getProductImage(ProductID id, int index) => _root.child("products/$id/$index");
  @override
  Reference getUserImagePath(UserID id) => _root.child("users/$id/profile_pic");
}
