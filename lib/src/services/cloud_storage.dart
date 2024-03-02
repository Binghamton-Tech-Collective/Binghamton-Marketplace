import "dart:io";
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
  Future<void> uploadFile({required File file, required String path}) async {}
}

/// Pick the file that the user uploads and track if the user cancelled the upload or sucessfully uploaded the file.

Future<PlatformFile?> pickFile() async {
  // Call `FilePicker.platform.pickFiles()`.
  // See: https://pub.dev/documentation/file_picker/latest/file_picker/FilePicker/pickFiles.html
  final result = await FilePicker.platform.pickFiles();
  if (result != null) {
    return result.files.first;
  } else {
    return null;
  }
}

/// Upload the file to firebase storage

Future<String?> uploadFile(Uint8List data, String path) async {
  // Make a Reference to the file at path
  // Upload the data into that reference
  // Call `Reference.putData()`
  // See: https://pub.dev/documentation/firebase_storage/latest/firebase_storage/Reference/putData.html
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
