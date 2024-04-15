export "src/services/auth.dart";
export "src/services/database.dart";
export "src/services/cloud_storage.dart";
export "src/services/service.dart";

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

  /// Deletes a [SellerProfile] and all of their associated data.
  Future<void> deleteSellerProfile(SellerID id) async {
    final reviews = await database.getReviewsBySellerID(id);
    for (final review in reviews) {
      await deleteReview(review.id);
    }
    final products = await database.getProductsBySellerID(id);
    for (final product in products) {
      await deleteProduct(product.id);
    }
    await database.deleteSellerProfile(id);
    await cloudStorage.deleteSellerProfile(id);
  }

  /// Deletes a product and all data associated with it.
  Future<void> deleteProduct(ProductID id) async {
    final reviews = await database.getReviewsByProductID(id);
    for (final review in reviews) {
      await deleteReview(review.id);
    }
    await database.deleteProduct(id);
    await cloudStorage.deleteProduct(id);
  }

  /// Deletes a review and all data associated with it.
  Future<void> deleteReview(ReviewID id) async {
    await database.deleteReview(id);
  }
}

/// A global singleton that contains all the services of this app.
final services = Services();
