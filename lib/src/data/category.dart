import "types.dart";

/// A category of product.
enum Category {
  /// The books category.
  books(id: CategoryID("books"), title: "Books", description: "Books for you to read!", imagePath: "assets/categories/books.png"),
  /// The furniture category.
  furniture(id: CategoryID("furniture"), title: "Furniture", description: "Furniture for your room!", imagePath: "assets/categories/furniture.png"),
  /// The clothing category.
  clothes(id: CategoryID("clothes"), title: "Clothes", description: "Clothes you can feel good in!", imagePath: "assets/categories/clothes.png"),
  /// The crafts category.
  crafts(id: CategoryID("crafts"), title: "Crafts", description: "Crafts to decorate with!", imagePath: "assets/categories/crafts.png"),
  /// The food category.
  food(id: CategoryID("food"), title: "Food", description: "Tasty treats for you to eat!", imagePath: "assets/categories/food.png"),
  /// The plants category.
  plants(id: CategoryID("plants"), title: "Plants", description: "Pretty plants you can grow!", imagePath: "assets/categories/plants.png"),
  /// The other category.
  other(id: CategoryID("other"), title: "Other", description: "...", imagePath: "assets/categories/other.png");
  
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
