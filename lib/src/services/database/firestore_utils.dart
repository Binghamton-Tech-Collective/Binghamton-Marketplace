import "package:cloud_firestore/cloud_firestore.dart";
import "package:meta/meta.dart";

import "package:btc_market/data.dart";


/// Helpful functions to call on a [CollectionReference].
extension CollectionUtils<T> on CollectionReference<T> {
  /// A wrapper around [withConverter].
  Collection<R, I> convert<R, I>({
    required R Function(Json) fromJson,
    required Json Function(R) toJson,
  }) => Collection<R, I>(
    withConverter(
      fromFirestore: (snapshot, options) => fromJson(snapshot.data()!),
      toFirestore: (item, options) => toJson(item),
    ),
  );
}

/// A safe view over [CollectionReference] that only allows the correct ID type.
extension type Collection<T, I>(CollectionReference<T> collection) implements CollectionReference<T> {
  /// Checks whether a document ID exists in this collection.
  Future<bool> contains(I id) async => (await doc(id).get()).exists;

  /// Gets the document with the given ID, or a new ID if needed.
  @redeclare
  DocumentReference<T> doc([I? path]) => collection.doc(path as String?);

  /// Gets a new ID for this collection.
  I get newID => doc().id as I;
}

/// Helpful functions to call on a [DocumentReference].
extension DocumentUtils<E> on DocumentReference<E> {
  /// Gets the data out of this document.
  Future<E?> getData() async => (await get()).data();

  /// Listens for updates to a document.
  Stream<E?> listen() => snapshots().map((snapshot) => snapshot.data());
}

/// Helpful functions to call on a [Query].
extension QueryUtils<E> on Query<E> {
  /// Gets all the data from a query.
  Future<List<E>> getAll() async => [
    for (final document in (await get()).docs) document.data(),
  ];

  /// Gets the first document that matches the query, if any exists.
  Future<E?> getFirst() async => (await limit(1).get()).docs.firstOrNull?.data();
}
