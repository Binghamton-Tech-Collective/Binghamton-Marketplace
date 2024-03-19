export "src/services/service.dart";
export "src/services/database.dart";

import "src/services/service.dart";
import "src/services/auth.dart";
import "src/services/firebase.dart";
import "src/services/database.dart";
import "src/services/cloud_storage.dart";

/// A [Service] that manages all other services used by the app.
class Services extends Service {
  /// The Firebase service
  final firebase = FirebaseService();
  /// The database service.
  final database = Database();
  /// The authentication service.
  final auth = AuthService();
  /// The cloud_storage service
  final cloudStorage = CloudStorageService();
  
  @override
  Future<void> init() async {
    await firebase.init();
    await auth.init();
    await database.init();
    await cloudStorage.init();
  }

  @override
  Future<void> dispose() async {
    await database.dispose();
    await auth.dispose();
    await firebase.dispose();
    await cloudStorage.dispose();
  }
}

/// A global singleton that contains all the services of this app.
final services = Services();
