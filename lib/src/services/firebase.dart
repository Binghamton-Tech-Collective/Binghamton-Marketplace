import "package:firebase_core/firebase_core.dart";

import "package:btc_market/firebase_options.dart";
import "service.dart";

/// Initializes the Firebase Core plugin.
class FirebaseService extends Service {
  @override
  Future<void> init() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
