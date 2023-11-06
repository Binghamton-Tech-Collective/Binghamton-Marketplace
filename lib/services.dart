export "src/services/service.dart";
export "src/services/database.dart";

import "src/services/service.dart";
import "src/services/auth.dart";
import "src/services/firebase.dart";
import "src/services/database.dart";

/// A [Service] that manages all other services used by the app.
class Services extends Service {
  /// The Firebase service
  final firebase = FirebaseService();
  /// The database service.
  final database = Database();
  /// The authentication service.
  final auth = AuthService();
  
  @override
  Future<void> init() async {
    await firebase.init();
    await auth.init();
    await database.init();
  }

  @override
  Future<void> dispose() async {
    await database.dispose();
    await auth.dispose();
    await firebase.dispose();
  }
}

/// A global singleton that contains all the services of this app.
final services = Services();
