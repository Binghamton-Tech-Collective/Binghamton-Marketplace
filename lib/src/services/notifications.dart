import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:firebase_core/firebase_core.dart";
import "package:firebase_messaging/firebase_messaging.dart";

@pragma('vm:entry-point')
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print("Backgroudn Notification: Reached here");
}

///
class Notifications extends Service {
  /// Instance to send notifications
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  ///
  @override
  Future<void> init() async {
    NotificationSettings settings = await firebaseMessaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      print("Foreground message");
    });
  }

  /// Notify the user about a message
  Future<void> sendNotification() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    models.user.userProfile!.token = fcmToken;
    await models.user.updateProfile(models.user.userProfile!);
    print("The profile has been updated with the token!");
    print("TOKEN: $fcmToken");
    print("ID: ${models.user.userProfile!.id}");
  }

  @override
  Future<void> dispose() {
    throw UnimplementedError();
  }
}
