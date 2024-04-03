import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
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
    floatingActionButton: FloatingActionButton(
      onPressed: () => models.user.sellerProfiles.isNotEmpty
        ? router.go("/products/create")
        : router.go("/sellers/no-profile"),
      tooltip: "Add Product",
      backgroundColor: Colors.grey[200],
      child: const Icon(Icons.add),
    ),
    floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    bottomNavigationBar: BottomAppBar(
      shape: const CircularNotchedRectangle(),
      child: NavigationBar(
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
    ),
  );      
} 
