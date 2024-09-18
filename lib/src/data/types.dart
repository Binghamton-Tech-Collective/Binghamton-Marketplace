/// An alias for a JSON object
typedef Json = Map<String, dynamic>;

/// A unique ID for every user.
extension type const UserID(String id) { }

/// A unique ID for every product.
extension type const ProductID(String id) { }

/// A unique ID for every Category
extension type const CategoryID(String id) { }

/// A unique ID for every seller.
extension type const SellerID(String id) { }

/// A unique ID for every review.
extension type const ReviewID(String id) { }

/// A unique ID for every conversation.
extension type const ConversationID(String id) implements String { }

/// Helpful methods on strings.
extension StringUtils on String {
  /// Returns this string, or null if it's empty.
  String? get nullIfEmpty => isEmpty ? null : this;

  /// Only the first line of this string.
  String get firstLine => split("\n").first;
}

/// Helpful methods on iterables.
extension IterableUtils<E> on Iterable<E> {
  /// Like Python's enumerate function.
  Iterable<(int, E)> get enumerate sync* {
    var index = 0;
    for (final element in this) {
      yield (index++, element);
    }
  }

  /// Returns this iterable, or null if this is empty.
  Iterable<E>? get nullIfEmpty => isEmpty ? null : this;

  /// Returns the first element, or null if this list is empty.
  E? get firstOrNull => isEmpty ? null : first;

  /// Returns the last element, or null if this list is empty.
  E? get lastOrNull => isEmpty ? null : last;
}

/// Like Python's range function.
Iterable<int> range(int end) sync* {
  for (var i = 0; i < end; i++) {
    yield i;
  }
}

/// Like Python's zip function.
Iterable<(E1, E2)> zip<E1, E2>(List<E1> list1, List<E2> list2) sync* {
  if (list1.length != list2.length) throw ArgumentError("Trying to zip lists of different lengths");
  for (var index = 0; index < list1.length; index++) {
    yield (list1[index], list2[index]);
  }
}

/// Utils on [Map].
extension MapUtils<K, V> on Map<K, V> {
  /// Gets all the keys and values as 2-element records.
	Iterable<(K, V)> get records => entries.map((entry) => (entry.key, entry.value));
}
