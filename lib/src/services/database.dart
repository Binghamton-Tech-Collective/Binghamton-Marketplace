import "package:cloud_firestore/cloud_firestore.dart";
import "package:btc_market/data.dart";
import "package:meta/meta.dart";

import "service.dart";
  
/// Helpful functions to call on a [CollectionReference].
extension CollectionUtils<T> on CollectionReference<T> {
  /// A wrapper around [withConverter].
  Collection<R, I> convert<R, I extends String>({
    required R Function(Json) fromJson,
    required Json Function(R) toJson,
  }) => Collection<R, I>(withConverter(
    fromFirestore: (snapshot, options) => fromJson(snapshot.data()!), 
    toFirestore: (item, options) => toJson(item),
  ),);
}

/// A safe view over [CollectionReference] that only allows the correct ID type.
extension type Collection<T, I extends String>(CollectionReference<T> collection) implements CollectionReference<T> {
  /// Checks whether a document ID exists in this collection.
  Future<bool> contains(I id) async => (await doc(id).get()).exists;

  /// Gets the document with the given ID, or a new ID if needed.
  @redeclare
  DocumentReference<T> doc([I? path]) => collection.doc(path);
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
  Collection<UserProfile, UserID> get users => firestore.collection("users").convert(
    fromJson: UserProfile.fromJson,
    toJson: (user) => user.toJson(),
  );

  /// A collection of [SellerProfile] objects.
  Collection<SellerProfile, SellerID> get sellers => firestore.collection("sellers").convert(
    fromJson: SellerProfile.fromJson,
    toJson: (seller) => seller.toJson(),
  );
  
  /// A collection of [Review] objects.
  Collection<Review, ReviewID> get reviews => firestore.collection("reviews").convert(
    fromJson: Review.fromJson,
    toJson: (review) => review.toJson(),
  );

  /// A collection of [Product] objects.
  Collection<Product, ProductID> get products => firestore.collection("products").convert(
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

  /// Gets all the reviews about the given seller.
  Future<List<Review>> getReviewsBySellerID(SellerID sellerID) => 
    reviews.where("sellerID", isEqualTo: sellerID).getAll();

    /// Gets a list of products listed by the seller with the given [sellerID]. 
  Future<List<Product>> getProductsBySellerID(SellerID sellerID) => 
    products.where("sellerID", isEqualTo: sellerID).getAll();

  /// Gets the seller profile owned by the given user ID
  Future<SellerProfile?> getSellerProfile(SellerID sellerID) => sellers.doc(sellerID).getData();

  /// Gets the product from the the given product ID
  Future<Product?> getProduct(ProductID productID) => products.doc(productID).getData();
}
