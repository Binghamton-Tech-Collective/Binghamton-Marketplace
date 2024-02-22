import "package:cloud_firestore/cloud_firestore.dart";
import "package:btc_market/data.dart";

import "service.dart";
  
/// Helpful functions to call on a [CollectionReference].
extension CollectionUtils<T> on CollectionReference<T> {
  /// A wrapper around [withConverter].
  CollectionReference<R> convert<R>({
    required R Function(Json) fromJson,
    required Json Function(R) toJson,
  }) => withConverter(
    fromFirestore: (snapshot, options) => fromJson(snapshot.data()!), 
    toFirestore: (item, options) => toJson(item),
  );

  /// Checks whether a document ID exists in this collection.
  Future<bool> contains(String id) async => (await doc(id).get()).exists;
}

/// Helpful functions to call on a [DocumentReference].
extension DocumentUtils<E> on DocumentReference<E> {
  /// Gets the data out of this document.
  Future<E?> getData() async => (await get()).data();
}

/// Helpful functions to call on a [Query].
extension QueryUtils<E> on Query<E> {
  /// Gets all the data from a query.
  Future<List<E>> getAll() async => [
    for (final document in (await get()).docs) 
      document.data(),
  ];
}

/// A service to interface with our database, Firebase's Cloud Firestore.
class Database extends Service {
  /// The Cloud Firestore plugin.
  FirebaseFirestore get firestore => FirebaseFirestore.instance;

  /// A collection of [UserProfile] objects.
  CollectionReference<UserProfile> get users => firestore.collection("users").convert<UserProfile>(
    fromJson: UserProfile.fromJson,
    toJson: (user) => user.toJson(),
  );

  /// A collection of [SellerProfile] objects.
  CollectionReference<SellerProfile> get sellers => firestore.collection("sellers").convert<SellerProfile>(
    fromJson: SellerProfile.fromJson,
    toJson: (seller) => seller.toJson(),
  );
  
  /// A collection of [Review] objects.
  CollectionReference<Review> get reviews => firestore.collection("reviews").convert<Review>(
    fromJson: Review.fromJson,
    toJson: (review) => review.toJson(),
  );

  /// A collection of [Product] objects.
  CollectionReference<Product> get products => firestore.collection("products").convert<Product>(
    fromJson: Product.fromJson,
    toJson: (product) => product.toJson(),
  );
  
  @override
  Future<void> init() async { }

  @override
  Future<void> dispose() async { }

  /// Gets the currently signed-in user's profile.
  Future<UserProfile?> getUserProfile(UserID userId) => users.doc(userId).getData();

  /// Saves the user's profile to their user document (in [users]).
  Future<void> saveUserProfile(UserProfile user) => users.doc(user.id).set(user);

  /// Gets all the reviews of the seller with the given [sellerID]
  Future<List<Review>> getReviewsBySellerID(SellerID sellerID) => 
    reviews.where("sellerID", isEqualTo: sellerID).getAll();

    /// Gets a list of products listed by the seller with the given [sellerID]. 
  Future<List<Product>> getProductsBySellerID(SellerID sellerID) => 
    products.where("sellerID", isEqualTo: sellerID).getAll();

  /// Gets all the reviews about the given product with the given [productID]
  Future<List<Review>> getReviewsByProductID(ProductID productID) => 
    reviews.where("productID", isEqualTo: productID).getAll();

  /// Gets the seller profile owned by the given user ID
  Future<SellerProfile?> getSellerProfile(UserID userID) => sellers.doc(userID).getData();

  /// Gets the product from the the given product ID
  Future<Product?> getProduct(ProductID productID) => products.doc(productID).getData();


  /// Gets a list of products who's searchWord list contains the given [searchTerm]
  Future<List<Product>> getProductsBySearchWord(String searchTerm) => 
    products.where("_searchWords", arrayContains: searchTerm).getAll();


}
