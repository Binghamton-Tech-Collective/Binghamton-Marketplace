import "types.dart";

/// A review about a specific product or just a seller themselves.
class Review { 
  /// This review's unique Review ID.
  final ReviewID id;
  /// The author's unique User ID. 
  final UserID authorID;
  /// The unique Product ID of the product this is reviewing.
  /// 
  /// If this review is not about a product, this will be null.
  final ProductID? productID;
  /// The unique Seller ID of the seller this review is about.
  final SellerID sellerID;

  /// The name of the user who created this review. 
  final String authorName;
  /// The date and time this review was created.
  final DateTime dateTime;
  /// The number of stars the reviewer gave.
  final int stars;
  /// The title of the review.
  final String title;
  /// The body of the review.
  final String body;

  /// A constructor to make a new review.
  const Review({
    required this.id,
    required this.authorID,
    required this.sellerID,
    required this.authorName,
    required this.dateTime, 
    required this.stars, 
    required this.title,
    required this.body,
    this.productID,
  });

  /// Creates a new Review object from a JSON object.
  Review.fromJson(Json json) : 
    id = json["id"],
    authorID = json["authorID"],
    sellerID = json["sellerID"],
    authorName = json["authorName"],
    dateTime = DateTime.parse(json["dateTime"]), 
    stars = json["stars"], 
    title = json["title"],
    body = json["body"],
    productID = json["productID"];

  /// Convert this Message to its JSON representation
  Json toJson() => {
    "id": id,
    "authorID": authorID,
    "sellerID": sellerID,
    "authorName": authorName,
    "dateTime": dateTime.toIso8601String(), 
    "stars": stars, 
    "title": title,
    "body": body,
    "productID": productID,
  };
}
