import "../model.dart";

class NotificationViewModel extends ViewModel {
  /// The user's name.
  late String name;

  /// The user's number of likes.
  late int numLikes;
  
  @override
  Future<void> init() async {
    isLoading = true;
    // Simulates a delay 
    await Future<void>.delayed(const Duration(seconds: 2));
    name = "Sam";
    numLikes = 100000;
    notifyListeners();
    isLoading = false;
  }
}
