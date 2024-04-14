export "src/models/model.dart";
export "src/models/utils.dart";

export "src/models/data/app.dart";
export "src/models/data/user.dart";

export "src/models/builders/product.dart";
export "src/models/builders/product_filters.dart";
export "src/models/builders/seller_profile.dart";

export "src/models/view/conversation.dart";
export "src/models/view/conversations.dart";
export "src/models/view/user_profile.dart";
export "src/models/view/product.dart";
export "src/models/view/notifications.dart";
export "src/models/view/seller_profile.dart";
export "src/models/view/login.dart";
export "src/models/view/products.dart";

import "src/models/model.dart";
import "src/models/data/app.dart";
import "src/models/data/user.dart";

/// A [DataModel] to manage all other data models.
class Models extends DataModel {
  /// The user data model.
  final user = UserModel();
  final app = AppModel();
  
  @override
  Future<void> init() async {
    await app.init();
    await user.init();
  }

  @override
  void dispose() {
    user.dispose();
    app.dispose();
    super.dispose();
  }
}

/// The global data model singleton.
final models = Models();
