import "../service.dart";

/// A service that enables and handles push notifications.
abstract class NotificationsService extends Service {
  /// The user's unique Firebase FCM token.
  ///
  /// For more details, see https://firebase.google.com/docs/cloud-messaging/manage-tokens.
  String? get firebaseToken;

  /// Requests permission from the user to show push notifications.
  ///
  /// This should be done in response to a user-initiated button press, and not automatically on
  /// startup. Not only is it good practice and UI design (don't bother the user unless they ask),
  /// but Chrome will actually reject all requests that don't follow a user gesture.
  Future<void> requestPermission();
}
