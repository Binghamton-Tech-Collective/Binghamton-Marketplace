import "dart:async";

import "package:btc_market/models.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// The navigation page, allows switching between other pages.
class ShellPage extends StatelessWidget {
  /// The body of the page, which also allows us to switch branches.
  final StatefulNavigationShell shell;
  /// A const constructor.
  ShellPage(this.shell, GoRouterState state) {
    Timer.run(() => models.app.title = state.topRoute?.name ?? "ShopBing");
  }
  
  @override
  Widget build(BuildContext context) => Scaffold(
    body: shell,
    bottomNavigationBar: NavigationBar(
      selectedIndex: shell.currentIndex,
      onDestinationSelected: shell.goBranch,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.storefront),
          label: "Products",
          ),
        NavigationDestination(
          icon: Icon(Icons.message),
          label: "Message",
          ),
        NavigationDestination(
          icon: Icon(Icons.groups),
          label: "Sellers",
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: "My Profile",
        ),
      ],
    ),
  );      
} 
