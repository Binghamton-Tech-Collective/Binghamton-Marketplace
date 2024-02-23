/// An alias for a JSON object
typedef Json = Map<String, dynamic>;

/// A unique ID for every user.
extension type const UserID(String id) implements String { }

/// A unique ID for every product.
extension type const ProductID(String id) implements String { }

/// A unique ID for every Category
extension type const CategoryID(String id) implements String { }

/// A unique ID for every seller.
extension type const SellerID(String id) implements String { }

/// A unique ID for every review.
extension type const ReviewID(String id) implements String { }
