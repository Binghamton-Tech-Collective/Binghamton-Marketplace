import "package:btc_market/models.dart";
import "package:btc_market/services.dart";
import "package:firebase_messaging/firebase_messaging.dart";

@pragma("vm:entry-point")
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {}

///
class Notifications extends Service {
  /// Instance to send notifications
  FirebaseMessaging get firebaseMessaging => FirebaseMessaging.instance;

  ///
  @override
  Future<void> init() async {
    await firebaseMessaging.requestPermission();
    FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {});
  }

  /// Notify the user about a message
  Future<void> sendNotification() async {
    await firebaseMessaging.requestPermission();
    final fcmToken = await firebaseMessaging.getToken();
    if(models.user.userProfile != null) {
      models.user.userProfile!.token = fcmToken;
      await models.user.updateProfile(models.user.userProfile!);
    }
  }

  @override
  Future<void> dispose() {
    throw UnimplementedError();
  }
}
