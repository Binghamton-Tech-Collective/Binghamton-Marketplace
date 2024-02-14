import "package:cloud_firestore/cloud_firestore.dart";
import "package:btc_market/data.dart";

import "service.dart";

/// A service to interface with our database, Firebase's Cloud Firestore.
class Database extends Service {
  /// The Cloud Firestore plugin.
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// A collection of [UserProfile] objects.
  CollectionReference<UserProfile> get users => firestore.collection("users").withConverter<UserProfile>(
    fromFirestore: (snapshot, _) => UserProfile.fromJson(snapshot.data()!),
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
  Future<UserProfile?> getUserProfile(UserID userId) async { 
    final doc = users.doc(userId);
    final snapshot = await doc.get();
    return snapshot.data();
  }

  /// Saves the user's profile to their user document (in [users]).
  Future<void> saveUserProfile(UserProfile user) async {
    final doc = users.doc(user.id);
    await doc.set(user);
  }

  /// Gets a list of reviews for the seller with the given ID. 
  Future<List<Review>> getReviewsBySellerID(SellerID id) async => [];

  /// Gets the seller profile owned by the given user ID
  Future<SellerProfile?> getSellerProfile(UserID userID) async => null;
}
