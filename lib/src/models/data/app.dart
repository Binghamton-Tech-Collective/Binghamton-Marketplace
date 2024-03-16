import "../model.dart";

class AppModel extends ViewModel {
  String _title = "ShopBing";
  String get title => _title;
  set title(String value) {
    _title = value;
    notifyListeners();
  }
}
