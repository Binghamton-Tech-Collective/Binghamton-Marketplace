import "dart:io";
import "service.dart";

class CloudStorageService extends Service {
  @override
  Future<void> init() async { }

  @override
  Future<void> dispose() async  { }

  Future<String> uploadPhoto(File photo) async {
    // upload to Google Cloud/Firebase Storage
    // return the URL
    return "";
  }
}
