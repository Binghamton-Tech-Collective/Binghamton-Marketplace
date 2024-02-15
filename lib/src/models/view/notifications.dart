import "../model.dart";

/// A view model for the notifications page.
class NotificationViewModel extends ViewModel {
  @override
  Future<void> init() async {
    isLoading = true;
    // Get notifications here
    isLoading = false;
  }
}
