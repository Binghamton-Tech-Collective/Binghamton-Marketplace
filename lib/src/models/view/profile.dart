import "../model.dart";

/// A view model for the profile page.
/// 
/// This is an example of a view model that does some initialization work. You'll notice that the
/// fields are "late", meaning they don't initialize to null but rather they don't initialize at
/// all. You are not allowed to access them until they are given a concrete, non-null value, so
/// we set [isLoading] to true to signal that the UI should load something else in the meantime.
/// 
/// As an aside, normally you wouldn't have a separate field for [name], [], etc, but 
/// instead you'd have a `SellerProfile` class and have *that* be a field here, and you can
/// access the name from there. 
class ProfileViewModel extends ViewModel {

  // ignore: public_member_api_docs
  late String name;
  late String major;
  
  @override
  Future<void> init() async {
    isLoading = true;
    // Simulates a delay 
    await Future<void>.delayed(const Duration(seconds: 2));
    name = "Samuel Montes";
    major = "Computer Science";
    notifyListeners();
    isLoading = false;
  }
}
