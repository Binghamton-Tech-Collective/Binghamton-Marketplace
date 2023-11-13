class Review { 
  final String id;
  final String authorName;
  final DateTime dateTime;
  final int stars;
  final String body;
  final String authorID;
  final String? productID;
  final String? sellerID;

  const Review({
    required this.id,
    required this.authorName,
    required this.authorID,
    required this.dateTime, 
    required this.stars, 
    required this.body, 
    this.productID, 
    this.sellerID,
  });
}
