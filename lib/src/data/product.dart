class Product {
  final String id;
  final String sellerID;

  final String title;
  final String description;
  final double price;
  final int quantity;
  final List<String> imageUrls;

  const Product({
    required this.id,
    required this.sellerID,
    required this.title, 
    required this.description, 
    required this.price, 
    required this.quantity, 
    required this.imageUrls, 
  });
}
