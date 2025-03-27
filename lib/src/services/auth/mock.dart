import "package:btc_market/data.dart";

import "interface.dart";

/// A mock implementation of [Auth] that always succeeds.
class MockAuth extends Auth {
  bool _isSignedIn = false;

  @override
  Future<void> init() async { }

  @override
  Future<void> signIn() async => _isSignedIn = true;

  @override
  Future<void> signOut() async => _isSignedIn = false;

  @override
  UserID? get userID => _isSignedIn ? mockUser.id : null;

  @override
  String? get email => _isSignedIn ? "mockUser@gmail.com" : null;
}
