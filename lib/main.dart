import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_web_plugins/url_strategy.dart";
import "package:go_router/go_router.dart";

import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();
  await services.init();
  await models.init();
  runApp(BtcMarket());
}

/// The classic Binghamton green, "Pantone 342"
const darkGreen = Color(0xFF005A43);
/// A light grey to accent the dark green.
const lightGrey = Color(0xFFDEDEDE);

/// Our main app. Remember, everything is a widget!
class BtcMarket extends StatelessWidget {  
  @override
  Widget build(BuildContext context) => MaterialApp.router(
    routerConfig: router,
    title: "ShopBing",
    scrollBehavior: const MaterialScrollBehavior().copyWith(
      dragDevices: {
        PointerDeviceKind.mouse, 
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      },
    ),
    theme: ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: darkGreen,
        primaryContainer: Colors.blueGrey.shade200,
        onPrimaryContainer: Colors.black,
        secondary: lightGrey,
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
