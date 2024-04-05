export "src/services/service.dart";
export "src/services/database.dart";

import "package:btc_market/data.dart";

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

  Future<void> deleteSellerProfile(SellerID id) async {
    final products = await database.getProductsBySellerID(id);
    for (final product in products) {
      await deleteProduct(product.id);
    }
    await database.deleteSellerProfile(id);
    await cloudStorage.deleteSellerProfile(id);
  }

  Future<void> deleteProduct(ProductID id) async {
    await database.deleteProduct(id);
    await cloudStorage.deleteProduct(id);
  }
}

/// A global singleton that contains all the services of this app.
final services = Services();
