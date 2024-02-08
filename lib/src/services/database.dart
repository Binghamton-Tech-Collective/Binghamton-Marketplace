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

  /// A collection of [SellerProfile] objects.
  CollectionReference<SellerProfile> get sellers => firestore.collection("sellers").withConverter<SellerProfile>(
    fromFirestore: (snapshot, _) => SellerProfile.fromJson(snapshot.data()!),
    toFirestore: (sellers, _) => sellers.toJson(),
  );
  
  /// A collection of [Review] objects.
  CollectionReference<Review> get reviews => firestore.collection("reviews").withConverter<Review>(
    fromFirestore: (snapshot, _) => Review.fromJson(snapshot.data()!),
    toFirestore: (reviews, _) => reviews.toJson(),
  );

  /// A collection of [Product] objects.
  CollectionReference<Product> get products => firestore.collection("products").withConverter<Product>(
    fromFirestore: (snapshot, _) => Product.fromJson(snapshot.data()!),
    toFirestore: (products, _) => products.toJson(),
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

  /// Gets a list of reviews for the seller with the given [sellerID]. 
  Future<List<Review>> getReviewsBySellerID(SellerID sellerID) async => 
  [
    // make a for loop for all the snapshots in the query
    for (final document in (await reviews.where("sellerID", isEqualTo: sellerID).get()).docs)
    
    // get the data out of the snapshot
    document .data(),
  ];

    /// Gets a list of products listed by the seller with the given [sellerID]. 
  Future<List<Product>> getProductsBySellerID(SellerID sellerID) async => 
  [
    for (final document in (await products.where("sellerID", isEqualTo: sellerID).get()).docs)
    document .data(),
  ];

  /// Gets the seller profile owned by the given user ID
  Future<SellerProfile?> getSellerProfile(UserID userID) async {
    final doc = sellers.doc(userID);
    final snapshot = await doc.get();
    return snapshot.data();
  }

}
