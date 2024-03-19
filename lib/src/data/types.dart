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
extension type const ConversationID(String id) { }

/// Some helpful methods on List
extension ListUtils<E> on List<E> {
  /// Returns the first element, or null if this list is empty.
  E? get firstOrNull => isEmpty ? null : first;
}
