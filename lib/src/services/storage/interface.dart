import "dart:io";
import "dart:typed_data";

import "package:btc_market/data.dart";
import "package:file_picker/file_picker.dart";

import "../service.dart";

// export "package:firebase_storage/firebase_storage.dart" show Reference;
export "dart:typed_data" show Uint8List;

/// A platform-agnostic file handle.
///
/// When using the local file system, this is a path that can be passed to [File.new].
/// When using Firebase Cloud Storage, this is a path to a Firebase reference.
extension type FileHandle(String path) { }

/// A service to perform CRUD operations on files in the cloud.
abstract class FilesService extends Service {
  /// Returns a file picked by the user.
  ///
  /// This isn't mocked by default since it's an offline function.
  Future<Uint8List?> pickImage() async {
    final result = await FilePicker.platform.pickFiles(
      dialogTitle: "Pick an image",
      type: FileType.image,
      withData: true,
    );
    if (result == null) return null;
    return result.files.firstOrNull?.bytes;
  }

  /// Uploads the given data to a file in the cloud.
  Future<String?> uploadFile(Uint8List data, FileHandle reference);

  /// Deletes the file at the given path.
  Future<void> deleteFile(String path);

  /// Deletes all data associated with a seller profile.
  Future<void> deleteSellerProfile(SellerID id);

  /// Deletes all data associated with a product.
  Future<void> deleteProduct(ProductID id);

  /// Gets the image path for [SellerProfile.imageUrl].
  FileHandle getSellerImagePath(SellerID id);

  /// Gets the image path for [Product.imageUrls].
  FileHandle getProductImage(ProductID id, int index);

  /// Gets the image path for [UserProfile.imageUrl].
  FileHandle getUserImagePath(UserID id);
}
