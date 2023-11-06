export "src/models/model.dart";
export "src/models/data/user.dart";
export "src/models/view/profile.dart";

import "src/models/model.dart";
import "src/models/data/user.dart";

/// A [DataModel] to manage all other data models.
class Models extends DataModel {
  /// The user data model.
  final user = UserModel();

  @override
  Future<void> init() async {
    await user.init();
  }

  @override
  void dispose() {
    user.dispose();
    super.dispose();
  }
}

/// The global data model singleton.
final models = Models();
