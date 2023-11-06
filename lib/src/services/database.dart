import "package:cloud_firestore/cloud_firestore.dart";
import "package:btc_market/data.dart";

import "service.dart";

/// A service to interface with our database, Firebase's Cloud Firestore.
class Database extends Service {
  /// The Cloud Firestore plugin.
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// A collection of [User] objects.
  CollectionReference<User> get users => firestore.collection("users").withConverter<User>(
    fromFirestore: (snapshot, _) => User.fromJson(snapshot.data()!),
    toFirestore: (user, _) => user.toJson(),
  );
  
  @override
  Future<void> init() async { 
    // Initialize the database, if needed
    await Future<void>.delayed(const Duration(seconds: 2));
  }

  @override
  Future<void> dispose() async { 
    // Perform any cleanup, if needed
  }

  /// Gets the currently signed-in user's profile.
  Future<User> getUserProfile(String userId) async { 
    final doc = users.doc(userId);
    final snapshot = await doc.get();
    return snapshot.data()!;
  }

  /// Saves the user's profile to their user document (in [users]).
  Future<void> saveUserProfile(User user) async {
    final doc = users.doc(user.userId);
    await doc.set(user);
  }
}
