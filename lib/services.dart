export "services/service.dart";
export "services/firestore.dart";

import "services/service.dart";
import "services/firestore.dart";

class Services extends Service {
  final database = Database();
  
  @override
  void init() {
    database.init();
  }

  @override
  void dispose() {
    database.dispose();
  }
}

final services = Services();
