import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";
import "package:firebase_messaging/firebase_messaging.dart";

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

/// The Firebase Cloud Messaging Service.
class Notifications extends Service {
  /// Instance to send notifications
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  /// Conversation ID of the chat if the app is opened from Notifications
  String? conversationId;

  /// The user's unique Firebase FCM token.
  ///
  /// For more details, see https://firebase.google.com/docs/cloud-messaging/manage-tokens.
  String? firebaseToken;

  @override
  Future<void> init() async {
    await firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
    firebaseToken = await firebaseMessaging.getToken();
    await firebaseMessaging.requestPermission();
    final initialMessage = await firebaseMessaging.getInitialMessage();
    if (initialMessage != null) handleNotification(initialMessage);
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);
  }

  /// Opens the correct page when a notification is pressed.
  void handleNotification(RemoteMessage message) {
    conversationId = message.data["conversationId"];
    final location = "/messages/$conversationId";
    router.go(location);
  }
}
