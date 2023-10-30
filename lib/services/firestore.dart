import "package:btc_market/data.dart";

import "service.dart";

class Database extends Service {
  @override
  void init() { 
    // Initialize the database, if needed
  }

  @override
  void dispose() { 
    // Perform any cleanup, if needed
  }

  User getUserProfile() { 
    final json = {"some": "data"}; 
    return User.fromJson(json);
  }
}
