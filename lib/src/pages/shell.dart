import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// The navigation page, allows switching between other pages.
class ShellPage extends StatelessWidget {
  /// The body of the page, which also allows us to switch branches.
  final StatefulNavigationShell shell;
  /// A const constructor.
  const ShellPage(this.shell);
  
  @override
  Widget build(BuildContext context) => Scaffold(
    body: shell,
    bottomNavigationBar: NavigationBar(
      selectedIndex: switch (shell.currentIndex) {
        0 || 1 => shell.currentIndex,
        2 || 3 => shell.currentIndex + 1,
        _ => shell.currentIndex,
      },
      onDestinationSelected: (index) => switch (index) {
        0 || 1 => shell.goBranch(index),
        2 => models.user.sellerProfiles.isNotEmpty
          ? router.go("/products/create")
          : router.go("/sellers/no-profile"),
        3 || 4 => shell.goBranch(index - 1),
        _ => null,
      },
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.storefront),
          label: "Products",
          ),
        NavigationDestination(
          icon: Icon(Icons.message),
          label: "Messages",
          ),
        NavigationDestination(
          icon: Icon(Icons.sell),
          label: "Sell Something",
          ),
        // Column(
        //   mainAxisSize: MainAxisSize.min,
        //   children: [
        //     IconButton(
        //       onPressed: () => models.user.sellerProfiles.isNotEmpty
        //         ? router.go("/products/create")
        //         : router.go("/sellers/no-profile"),
        //       tooltip: "Add Product",
        //       icon: const Icon(Icons.sell),
        //     ),
        //     Text("Sell something", style: context.textTheme.labelMedium),
        //   ],
        // ),
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
