import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";
import "package:btc_market/widgets.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await services.init();
  await models.init();
  runApp(BtcMarket());
}

/// Our main app. Remember, everything is a widget!
class BtcMarket extends ReusableReactiveWidget<AppModel> {
  BtcMarket() : super(models.app);
  
  @override
  Widget build(BuildContext context, AppModel model) => MaterialApp.router(
    routerConfig: router,
    title: model.title,
    theme: ThemeData(useMaterial3: true),
  );
}
