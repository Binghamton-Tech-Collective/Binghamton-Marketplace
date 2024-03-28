export "src/models/model.dart";
export "src/models/data/user.dart";

export "src/models/builders/seller_profile.dart";

export "src/models/view/profile.dart";
export "src/models/view/product.dart";
export "src/models/view/notifications.dart";
export "src/models/view/seller_profile.dart";
export "src/models/builders/product.dart";

import "src/models/model.dart";
import "src/models/data/user.dart";

/// A [DataModel] to manage all other data models.
class Models extends DataModel {
  /// The user data model.
  final user = UserModel();

  get product => null;

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
