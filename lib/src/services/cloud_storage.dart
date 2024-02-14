import "dart:io";
import "service.dart";

/// A service to use CRUD operations on Google Cloud Storage for Firebase. 
class CloudStorageService extends Service {
  @override
  Future<void> init() async { }

  @override
  Future<void> dispose() async  { }

  /// Uploads the file to Google Cloud Storage.
  Future<void> uploadFile({required File file, required String path}) async { }
}
