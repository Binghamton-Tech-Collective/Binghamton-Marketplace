import "package:btc_market/widgets.dart";
import "package:flutter/gestures.dart";
import "package:flutter/material.dart";
import "package:flutter_web_plugins/url_strategy.dart";

import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  GoRouter.optionURLReflectsImperativeAPIs = true;
  usePathUrlStrategy();
  await services.init();
  await models.init();
  runApp(BtcMarket(models.app));
}

/// The Student Association of Binghamton green.
///
/// Note that we are not authorized to use the Binghamton green, Pantone 342.
const darkGreen = Color(0XFF005A43);

/// A lighter green for high contrast in dark mode.
const lightGreen = Color.fromARGB(255, 0, 175, 150);

/// A light grey to accent the dark green.
const lightGrey = Color(0xFFDEDEDE);

/// Our main app. Remember, everything is a widget!
class BtcMarket extends ReusableReactiveWidget<AppModel> {
  /// A const constructor.
  const BtcMarket(super.model);

  @override
  Widget buildError(BuildContext context, AppModel model) => MaterialApp(
    theme: ThemeData.light(useMaterial3: true),
    darkTheme: ThemeData.dark(useMaterial3: true),
    home: Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("An error occurred", textScaler: TextScaler.linear(2.5), textAlign: TextAlign.center,),
            const SizedBox(height: 12),
            const Text("We're sorry, ShopBing is down for today. Please check back tomorrow", textScaler: TextScaler.linear(1.5), textAlign: TextAlign.center,),
            const SizedBox(height: 24),
            const Text("This usually indicates high usage, so there may be lots of new products when you check back!", textScaler: TextScaler.linear(1.25), textAlign: TextAlign.center,),
            const SizedBox(height: 24),
            Image.asset("assets/bearcat/waiting.png", scale: 0.75),
            const SizedBox(height: 24),
            Text("The exact error was: ${model.errorText}"),
          ],
        ),
      ),
    ),
  );

  @override
  Widget build(BuildContext context, AppModel model) => MaterialApp.router(
    debugShowCheckedModeBanner: false,
    routerConfig: router,
    title: "ShopBing",
    scrollBehavior: const MaterialScrollBehavior().copyWith(
      dragDevices: {
        PointerDeviceKind.touch,
        PointerDeviceKind.stylus,
        PointerDeviceKind.trackpad,
      },
    ),
    themeMode: model.theme,
    darkTheme: ThemeData(
      brightness: Brightness.dark,
      useMaterial3: true,
      colorScheme: ColorScheme.fromSeed(
        seedColor: darkGreen,
        brightness: Brightness.dark,
        primary: darkGreen,
        secondary: lightGrey,
        onPrimary: Colors.white,
        onSecondary: Colors.white,
        primaryContainer: Colors.blueGrey.shade800,
        onPrimaryContainer: Colors.white,
        secondaryContainer: Colors.grey.shade600,
        onSecondaryContainer: Colors.white,
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(foregroundColor: lightGreen),
      ),
    ),
    theme: ThemeData(
      brightness: Brightness.light,
      useMaterial3: true,
      colorScheme: ColorScheme.light(
        primary: darkGreen,
        primaryContainer: Colors.blueGrey.shade200,
        onPrimaryContainer: Colors.black,
        secondary: lightGrey,
        surfaceContainerHighest: Colors.grey[300],
      ),
      appBarTheme: const AppBarTheme(
        backgroundColor: darkGreen,
        foregroundColor: Colors.white,
      ),
    ),
  );
}
