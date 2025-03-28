import "package:btc_market/pages.dart";
import "package:firebase_messaging/firebase_messaging.dart";

import "interface.dart";

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

/// A push notifications service powered by Firebase Cloud Messaging.
class FirebaseNotifications extends NotificationsService {
  /// The global instance of the Firebase messaging service.
  FirebaseMessaging get firebase => FirebaseMessaging.instance;

  @override
  String? firebaseToken;

  @override
  Future<void> init() async {
    await firebase.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    firebaseToken = await firebase.getToken();
    await firebase.requestPermission();
    final initialMessage = await firebase.getInitialMessage();
    if (initialMessage != null) _handleNotification(initialMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(_handleNotification);
  }

  /// Opens the correct page when a notification is pressed.
  void _handleNotification(RemoteMessage message) {
    final conversationId = message.data["conversationId"];
    final location = "/messages/$conversationId";
    router.go(location);
  }
}
