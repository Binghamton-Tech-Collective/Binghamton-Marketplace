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

  /// Uploads the file to Google Cloud Storage.
  /// I'm not sure why this function was created, so I'm uncommenting it. I thought functions with same names but different signatures should work, but it throws an error saying that the names are duplicate. Let me know if we need this function for something else.
  // Future<void> uploadFile({required File file, required String path}) async {}

  /// Pick the file that the user uploads and track if the user cancelled the upload or sucessfully uploaded the file.

  Future<PlatformFile?> pickFile() async {
    final result = await FilePicker.platform.pickFiles();
    if (result != null) {
      return result.files.first;
    } else {
      return null;
    }
  }

  /// Upload the file to firebase storage

  Future<String?> uploadFile(Uint8List data, String path) async {
    final rootReference = FirebaseStorage.instance.ref();
    final directoryReference = rootReference.child(path);
    try {
      await directoryReference.putData(data);
      final downloadURL = directoryReference.getDownloadURL();
      return downloadURL;
    } catch (error) {
      return null;
    }
  }
}
