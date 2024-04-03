import "package:btc_market/data.dart";
import "package:btc_market/models.dart";
import "package:btc_market/services.dart";

/// The view model for loading list of all conversations for a user
class SellersViewModel extends ViewModel {
  /// The user profile of the user signed in
  final user = models.user.userProfile!;

  /// List of all the conversations for the user
  late List<SellerProfile> allSellers;

  @override
  Future<void> init() async {
    isLoading = true;
    try {
      allSellers = await services.database.getAllSellers(user.id)..sort(
        (a, b) => a.name.compareTo(b.name),
      );
    } catch (error) {
      errorText = "Error loading sellers list: \n$error";
      isLoading = false;
      rethrow;
    }
    isLoading = false;
  }
}
