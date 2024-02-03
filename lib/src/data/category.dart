import 'types.dart';

class Category {
  // Stores the unique ID for this category
  final CategoryID categoryID;
  // Stores the name of the category
  final String title;
  // Stores a brief description for the category
  final String description;
  // Stores the link of the thumbnail for this category
  final String imagePath;
  // When none of the products of the category are available, the category is still shown since the Product is not delisted. If the seller wants to get rid of the listing, they can simply set this to 'true' to hide this particular category from buyers.
  final bool delisted;

  const Category({
    required this.categoryID,
    required this.title,
    required this.description,
    required this.imagePath,
    this.delisted = false,
  });

  /**
   * The below methods will be used to define how to Objects of Category class are compared for equality.
   * By default, the compiler checks the memory location of the Objects created and return true if they point to the same memory address.
   * However, when we create a Set of Category for our seller profile view model, we want to define the equality on the basis of the categoryID.
   * Since each category has a different id, two objects with the same category id will be considered as duplicates and only entered in the Set once.
   */

  @override
  int get hashCode => categoryID.hashCode;

  @override
  bool operator ==(other) {
    return other is Category && other.categoryID == categoryID;
  }
}
