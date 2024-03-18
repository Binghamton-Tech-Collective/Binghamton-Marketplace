import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await services.init();
  await models.init();
  runApp(BtcMarket());
}

const darkGreen = Color(0xFF005A43);
const lightGrey = Color(0xFFDEDEDE);

/// Our main app. Remember, everything is a widget!
class BtcMarket extends StatelessWidget {  
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: router,
    title: "ShopBing",
    theme: ThemeData(
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: darkGreen,
        secondary: lightGrey,
      ),
    ),
  );
}
