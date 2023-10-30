import "package:btc_market/models.dart";

class LoginViewModel extends Model {
  bool isLoading = false;
  
  String username = "";
  String password = "";
  
  @override
  void init() { }

  bool signIn() {
    isLoading = true;
    notifyListeners();
    models.user.signIn(username, password);
    isLoading = false;
    notifyListeners();
    return models.user.isSignedIn();
  }
}
