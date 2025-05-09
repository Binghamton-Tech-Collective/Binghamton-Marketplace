import "package:btc_market/pages.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import "interface.dart";

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

extension on NotificationSettings {
  bool get accessGranted => authorizationStatus == AuthorizationStatus.authorized;
}

/// A push notifications service powered by Firebase Cloud Messaging.
class FirebaseNotifications extends NotificationsService {
  /// The global instance of the Firebase messaging service.
  FirebaseMessaging get firebase => FirebaseMessaging.instance;

  @override
  String? firebaseToken;

  @override
  Future<bool> hasPermission() async {
    final settings = await firebase.getNotificationSettings() ;
    return settings.accessGranted;
  }

  @override
  Future<void> requestPermission() async {
    final settings = await firebase.requestPermission();
    if (settings.accessGranted) {
      firebaseToken = await firebase.getToken();
    }
  }

  @override
  Future<void> init() async {
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    final initialMessage = await firebase.getInitialMessage();
    if (initialMessage != null) _handleNotification(initialMessage);
    FirebaseMessaging.onMessage.listen(_handleNotification);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);
  }

  /// Opens the correct page when a notification is pressed.
  void _handleNotification(RemoteMessage message) {
    final conversationId = message.data["conversationId"];
    final location = "/messages/$conversationId";
    router.go(location);
  }
}
