export "src/services/service.dart";
export "src/services/firestore.dart";

import "src/services/service.dart";
import "src/services/firestore.dart";

/// A [Service] that manages all other services used by the app.
class Services extends Service {
  /// The database service.
  final database = Database();
  
  @override
  Future<void> init() async {
    await database.init();
  }

  @override
  Future<void> dispose() async {
    await database.dispose();
  }
}

/// A global singleton that contains all the services of this app.
final services = Services();
