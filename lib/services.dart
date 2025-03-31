export "src/services/auth.dart";
export "src/services/database.dart";
export "src/services/files.dart";
export "src/services/service.dart";

import "package:btc_market/data.dart";

import "src/services/service.dart";
import "src/services/auth.dart";
import "src/services/firebase.dart";
import "src/services/database.dart";
import "src/services/files.dart";
import "src/services/notifications.dart";

/// Whether to use mock services and data.
const useMock = bool.fromEnvironment("mock");

/// A [Service] that manages all other services used by the app.
class Services extends Service {
  /// The Firebase service
  final firebase = FirebaseService();

  /// The database service.
  final database = useMock ? MockDatabase() : FirestoreDatabase();

  /// The authentication service.
  final auth = useMock ? MockAuth() : FirebaseAuthService();

  /// The files service
  final files = useMock ? MockFilesService() : CloudStorageService();

  /// The push notifications service
  final notifications = useMock ? MockPushNotifications() : FirebaseNotifications();

  @override
  Future<void> init() async {
    if (!useMock) await firebase.init();
    await auth.init();
    await database.init();
    await files.init();
    await notifications.init();
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
    await files.deleteSellerProfile(id);
  }

  /// Deletes a product and all data associated with it.
  Future<void> deleteProduct(ProductID id) async {
    final reviews = await database.getReviewsByProductID(id);
    for (final review in reviews) {
      await deleteReview(review.id);
    }
    await database.deleteProduct(id);
    await files.deleteProduct(id);
  }

  /// Deletes a review and all data associated with it.
  Future<void> deleteReview(ReviewID id) async {
    await database.deleteReview(id);
  }
}

/// A global singleton that contains all the services of this app.
final services = Services();
