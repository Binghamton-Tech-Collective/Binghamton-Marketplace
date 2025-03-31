import "interface.dart";

/// A mock service that does not use push notifications.
class MockPushNotifications extends NotificationsService {
  @override
  Future<void> init() async { }

  @override
  String? get firebaseToken => null;
}
