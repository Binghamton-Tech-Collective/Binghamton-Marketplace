import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/src/data/category.dart";
import "dart:collection";

class SellerProfileViewModel extends ViewModel {
  // The profile variable will hold the object of Seller Profile
  /// The profile will get the seller profile info from model of seller profile.
  SellerProfile? get profile => models.user.sellerProfile;

  /// This set stores the cateogories in which the user has their products listed.
  /// It is calculated on the basis of the product listings that the user has.
  Set<Category> categories;

  /// This list stores the list of products that the user currently has.
  /// The data for this list will be fetched from the database which will have the details of the products that the user is selling.
  List<Product> productList;

  /// Instantiates the SellerProfileViewModel class with the categories and Productlist.
  /// If the constructor is not provided with categories and / or the productlist, it will initialise an empty Set and a List.

  SellerProfileViewModel({
    Set<Category>? categories,
    List<Product>? productList,
  })  : categories = categories ?? HashSet(),
        productList = productList ?? <Product>[];

  /// The getImageURL() will return the link to the profile picture of the user.

  String? getImageURL() => profile?.imagePath;

  /// Returns the name of the seller
  String? getName() => profile?.name;

  /// The getSellerDescription method will return the description that can be used as a bio for the seller.
  String? getSellerDescription() => profile?.bio;

  /// The getCategories method will iterate through all the products that are listed in teh above list.
  /// It will then check what category does the product belong to.
  /// It will add the category to the set if the cateogry is not present in the set.

  Set<Category> getCategories() {
    for (final index in productList) {
      categories.add(index.category);
    }
    return categories;
  }

  /// The getProductListings method will return the list of the products from the database
  /// Returning a dummy list
  /// The actual code will run a firebase query returning all the Products for a particular seller.
  List<Product> getProductListings() => <Product>[];
}
