import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

/// This view model includes the logic required for the SellerProfile view
class SellerProfileViewModel extends ViewModel {
  /// Populates the Categories set by iterating the products
  static Set<Category> getCategories(List<Product> products) => {
    for (final product in products)
      ...product.categories,
  };
  
  // The profile variable will hold the object of Seller Profile
  /// The profile will get the seller profile info from model of seller profile.
  late final SellerProfile profile;

  /// This set stores the categories in which the user has their products listed.
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
    categories = getCategories(productList);
    isLoading = false;
  }

  /// Populates the Product List of Seller.
  Future<void> fetchProducts() async {
    // Will add the code here to fetch the product list and initialize the instance variable
    productList = <Product>[];
  }

  /// Returns the link to the profile picture of the user.
  String getImageURL() => profile.imageUrl;

  /// Returns the name of the seller
  String get name => profile.name;

  /// The method will return the description that can be used as a bio for the seller.
  String get sellerDescription => profile.bio;
}
