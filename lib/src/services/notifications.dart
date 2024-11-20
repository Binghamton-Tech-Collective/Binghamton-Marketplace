import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";
import "package:firebase_messaging/firebase_messaging.dart";
import "package:flutter/foundation.dart";

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

  /// Request permission from the OS to display permissions.
  Future<void> requestPermission() async {
    if (!kIsWeb) await firebaseMessaging.requestPermission();
  }

  @override
  Future<void> init() async {
    if (kIsWeb) return;
    await requestPermission();

    // Handle notifications received when the app is in the background or terminated
    // The app will not be able to open a UI in this state, and code will run in a separate thread
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

    // Handle notifications received while the app is in the foreground
    FirebaseMessaging.onMessage.listen(handleNotification);

    // Handle notifications that are tapped while the app is in the background
    FirebaseMessaging.onMessageOpenedApp.listen(handleNotification);

    // Handle notifications that are tapped since the app was last terminated
    final initialMessage = await firebaseMessaging.getInitialMessage();
    if (initialMessage != null) handleNotification(initialMessage);

    // Save the user's FCM token for later
    firebaseToken = await firebaseMessaging.getToken();
  }

  /// Opens the correct page when a notification is pressed.
  void handleNotification(RemoteMessage message) {
    conversationId = message.data["conversationId"];
    final location = "/messages/$conversationId";
    router.go(location);
  }

  @override
  Future<void> dispose() async { }
}
