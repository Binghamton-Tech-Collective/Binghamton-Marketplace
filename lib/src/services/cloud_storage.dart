import "dart:typed_data";
import "service.dart";
import "package:file_picker/file_picker.dart";
import "package:firebase_storage/firebase_storage.dart";

/// A service to use CRUD operations on Google Cloud Storage for Firebase.
class CloudStorageService extends Service {
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
    final rootReference = FirebaseStorage.instance.ref();
    final directoryReference = rootReference.child(path);
    try {
      await directoryReference.putData(data);
      final downloadURL = await directoryReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      return null;
    }
  }
}
