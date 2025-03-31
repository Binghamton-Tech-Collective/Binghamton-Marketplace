import "interface.dart";

/// A mock service that does not use push notifications.
class MockPushNotifications extends NotificationsService {
  @override
  Future<void> init() async { }

  @override
  String? get firebaseToken => _permission ? "123" : null;

  bool _permission = false;

  @override
  Future<void> requestPermission() async => _permission = true;

  @override
  Future<bool> hasPermission() async => _permission;
}
