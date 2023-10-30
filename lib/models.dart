export "models/model.dart";
export "models/data/user.dart";
export "models/view/login.dart";

import "models/model.dart";
import "models/data/user.dart";

class Models extends Model {
  final user = UserModel();

  @override
  void init() {
    user.init();
  }

  @override
  void dispose() {
    user.dispose();
    super.dispose();
  }
}

final models = Models();
