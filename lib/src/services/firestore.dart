import "package:btc_market/data.dart";

import "service.dart";

/// A service to interface with our database, Firebase's Cloud Firestore.
class Database extends Service {
  @override
  Future<void> init() async { 
    // Initialize the database, if needed
  }

  @override
  Future<void> dispose() async { 
    // Perform any cleanup, if needed
  }

  /// Gets the currently signed-in user's profile.
  User getUserProfile() { 
    final json = {"some": "data"}; 
    return User.fromJson(json);
  }
}
