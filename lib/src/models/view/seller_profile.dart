import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";

/// This view model includes the logic required for the SellerProfile view
class SellerProfileViewModel extends ViewModel {
  /// Populates the Categories set by iterating the products
  static Set<Category> getCategories(List<Product> products) => {
    for (final product in products) ...product.categories,
  };

  final SellerProfile? initialProfile;

  bool isLoadingProfile = false;
  bool isLoadingCategories = true;
  bool isLoadingProducts = true;

  // The profile variable will hold the object of Seller Profile
  /// The profile will get the seller profile info from model of seller profile.
  late SellerProfile profile;

  /// This set stores the categories in which the user has their products listed.
  /// It is calculated on the basis of the product listings that the user has.
  late Set<Category> categories;

  /// This list stores the list of products that the user currently has.
  /// The data for this list will be fetched from the database which will have the details of the products that the user is selling.
  /// Invoked the function to populate productListings and Categories.
  late List<Product> productList;

  /// The seller ID to view.
  SellerID id;

  /// Creates the seller view model.
  SellerProfileViewModel({
    required this.id,
    required this.initialProfile,
  });

  @override
  Future<void> init() async {
    if (initialProfile != null) {
      profile = initialProfile!;
    } else {
      isLoadingProfile = true;
      notifyListeners();
      final tempProfile = await services.database.getSellerProfile(id);
      if (tempProfile == null) {
        errorText = "Sorry, the profile $id doesn't exist";
        return;
      }
      profile = tempProfile;
      isLoadingProfile = false;
      notifyListeners();
    }
    productList = await services.database.getProductsBySellerID(profile.id);
    isLoadingProducts = false;
    notifyListeners();
    categories = getCategories(productList);
    isLoadingCategories = false;
    notifyListeners();
  }

  /// Returns the link to the profile picture of the user.
  String getImageURL() => profile.imageUrl;

  /// Returns the name of the seller
  String get name => profile.name;

  /// The method will return the description that can be used as a bio for the seller.
  String get sellerDescription => profile.bio;

  /// Open or creates conversation
  Future<void> openConversation() async {
    final buyer = models.user.userProfile!;
    final seller = profile;

    var conversation = await services.database.getConversation(buyer, profile);
    if (conversation == null) {
      final conversationID = services.database.conversations.newID;
      conversation = Conversation.start(
        id: conversationID,
        buyer: buyer,
        seller: seller,
      );
      await services.database.saveConversation(conversation);
    }
    router.push("/messages/${conversation.id}").ignore();
  }

  /// Function to edit the sellerProfile
  void editProfile() => router.push("/sellers/$id/edit");
}
