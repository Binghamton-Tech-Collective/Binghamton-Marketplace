import "../service.dart";

/// A service that enables and handles push notifications.
abstract class NotificationsService extends Service {
  /// The user's unique Firebase FCM token.
  ///
  /// For more details, see https://firebase.google.com/docs/cloud-messaging/manage-tokens.
  String? get firebaseToken;
}
