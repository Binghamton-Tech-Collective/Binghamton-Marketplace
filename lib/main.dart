import "package:flutter/material.dart";

import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/services.dart";

void main() {
  services.init();
  models.init();
  runApp(BtcMarket());
}

/// Our main app. Remember, everything is a widget!
class BtcMarket extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MaterialApp(
    home: NavPage(),
    theme: ThemeData(useMaterial3: true),
  );
}
