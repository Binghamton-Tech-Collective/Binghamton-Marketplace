import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/src/data/category.dart";

/// This view model includes the logic required for the SellerProfile view

class SellerProfileViewModel extends ViewModel {
  // The profile variable will hold the object of Seller Profile
  /// The profile will get the seller profile info from model of seller profile.
  late final SellerProfile profile;

  /// This set stores the cateogories in which the user has their products listed.
  /// It is calculated on the basis of the product listings that the user has.
  late final Set<Category> categories;

  /// This list stores the list of products that the user currently has.
  /// The data for this list will be fetched from the database which will have the details of the products that the user is selling.
  /// Invoked the function to populate productListings and Categories.
  late List<Product> productList;

  @override
  Future<void> init() async {
    isLoading = true;
    // get the seller's products, reviews, categories, etc
    profile = models.user.sellerProfile!;
    await fetchProducts();
    fetchCategories();
    isLoading = false;
  }

  /// Populates the Product List of Seller.
  Future<void> fetchProducts() async {
    // Will add the code here to fetch the product list and intialize the instance variable
    productList = <Product>[];
  }

  /// Populates the Categories set by iterating the products
  void fetchCategories() {
    for (final product in productList) {
      categories.addAll(product.categories);
    }
  }

  /// Returns the link to the profile picture of the user.
  String getImageURL() => profile.imagePath;

  /// Returns the name of the seller
  String get name => profile.name;

  /// The method will return the description that can be used as a bio for the seller.
  String get sellerDescription => profile.bio;

  /// The method will return the list of the products from the database
  /// Returning a dummy list
  /// The actual code will run a firebase query returning all the Products for a particular seller.
  Future<List<Product>> get sellerProducts async => productList;

  /// A getter method to return all the categories that the seller has listed
  Set<Category> get sellerCategories => categories;
}
