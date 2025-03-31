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

  /// Converts an agnostic [FileHandle] to a Firebase [Reference].
  ///
  /// Not all handles represent Firebase references, so only use this if you're sure
  /// your handle came from this class (which always uses references).
  Reference toFirebase(FileHandle handle) => _root.child(handle.path);

  @override
  Future<void> init() async {}

  @override
  Future<String?> uploadFile(Uint8List data, FileHandle handle) async {
    final reference = _root.child(handle.path);
    try {
      await reference.putData(data);
      final downloadURL = await reference.getDownloadURL();
      return downloadURL;
    } on FirebaseException {
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
  FileHandle getSellerImagePath(SellerID id) =>
    FileHandle(_root.child("sellers/$id/profile_pic").fullPath);

  @override
  FileHandle getProductImage(ProductID id, int index) =>
    FileHandle(_root.child("products/$id/$index").fullPath);

  @override
  FileHandle getUserImagePath(UserID id) =>
    FileHandle(_root.child("users/$id/profile_pic").fullPath);
}
