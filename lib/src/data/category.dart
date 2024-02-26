import "types.dart";

/// A category of product.
enum Category {
  /// The clothing category.
  clothes(id: CategoryID("clothes"), title: "Clothes", description: "Clothes you can feel good in!", imagePath: "assets/categories/clothes.png"),
  /// The books category.
  books(id: CategoryID("books"), title: "Books", description: "Clothes you can feel good in!", imagePath: "assets/categories/clothes.png");
  
  /// Stores the unique ID for this category
  final CategoryID id;

  /// Stores the name of the category
  final String title;

  /// Stores a brief description for the category
  final String description;

  /// Stores the link of the thumbnail for this category
  final String imagePath;

  /// Constructor to initialize the instances of Category class
  const Category({
    required this.id,
    required this.title,
    required this.description,
    required this.imagePath,
  });

  /// Gets a category from a JSON format.
  factory Category.fromJson(CategoryID id) => values.firstWhere((category) => category.id == id);
  
  /// Converts this category to a value you can store in a database.
  /// 
  /// Passing this back into [Category.fromJson] should return the same object.
  CategoryID toJson() => id;
}
