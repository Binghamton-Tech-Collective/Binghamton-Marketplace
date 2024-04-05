import "types.dart";

/// A category of product.
enum Category {
  /// The college essentials category.
  collegeEssentials(id: CategoryID("collegeEssentials"), title: "College Essentials", description: "Essential Items for college", imagePath: "assets/categories/collegeEssentials.png"),
  /// The books category.
  books(id: CategoryID("books"), title: "Books", description: "Books", imagePath: "assets/categories/books.png"),
  /// The clothing category.
  clothes(id: CategoryID("clothes"), title: "Clothes", description: "Clothes you can feel good in!", imagePath: "assets/categories/clothes.png"),
  /// The food category.
  food(id: CategoryID("food"), title: "Food Items", description: "Food Items", imagePath: "assets/categories/food.png"),
  /// The furniture category.
  furniture(id: CategoryID("furniture"), title: "Furniture", description: "Furniture", imagePath: "assets/categories/furniture.png"),
  /// The electronics category.
  electronics(id: CategoryID("electronics"), title: "Electronics", description: "Electronics", imagePath: "assets/categories/electronics.png"),
  /// The clothing category.
  crafts(id: CategoryID("crafts"), title: "Crafts", description: "Creative Crafts", imagePath: "assets/categories/craft.png"),
  /// The books category.
  jewelry(id: CategoryID("jewelry"), title: "Jewelry", description: "Jewelry you can feel good in!", imagePath: "assets/categories/jewelry.png"),
  /// The clothing category.
  accessories(id: CategoryID("accessories"), title: "Accessories", description: "Accessories", imagePath: "assets/categories/accessories.png"),
  /// The books category.
  sports(id: CategoryID("sports"), title: "Sports", description: "Sport Items!", imagePath: "assets/categories/sports.png"),
  /// The books category.
  other(id: CategoryID("other"), title: "Other", description: "Any special category", imagePath: "assets/categories/other.png");
  
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
