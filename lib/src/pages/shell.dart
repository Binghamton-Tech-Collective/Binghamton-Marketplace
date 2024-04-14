import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// A shell page that wraps the given page with a [BottomNavigationBar].
class ShellPage extends ReusableReactiveWidget<AppModel> {
  /// The main body of the app.
  final Widget child;
  
  /// Creates the navigation page.
  ShellPage(this.child) : super(models.app);

  @override
  void initModel(BuildContext context, AppModel model) => model.context = context;
  
  /// Goes to the page specified by the given index.
  void goIndex(int index) {
    final routeName = Routes.branches[index];
    router.go(routeName);
  }

  /// Gets the index based on the current route.
  int getIndex(BuildContext context) => Routes.branches.indexWhere(
    (branch) => GoRouterState.of(context).uri.path.contains(branch),
  );
  
  @override
  Widget build(BuildContext context, AppModel model) => Scaffold(
    body: child,
    floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
    bottomNavigationBar: NavigationBar(
      selectedIndex: getIndex(context),
      onDestinationSelected: goIndex,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.storefront),
          label: "Products",
        ),
        NavigationDestination(
          icon: Icon(Icons.groups),
          label: "Sellers",
        ),
        NavigationDestination(
          icon: Icon(Icons.sell),
          label: "Sell",
        ),
        NavigationDestination(
          icon: Icon(Icons.message),
          label: "Messages",
        ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: "My Profile",
        ),
      ],
    ),
  );
} 
