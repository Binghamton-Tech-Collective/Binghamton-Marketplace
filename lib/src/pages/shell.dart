import "package:btc_market/models.dart";
import "package:btc_market/pages.dart";
import "package:btc_market/widgets.dart";
import "package:flutter/material.dart";

/// A view model for the shell of the UI. Allows for app-wide changes.
class ShellViewModel extends ViewModel {
  /// A hook into the UI, to call [ScaffoldMessenger.of] with.
  BuildContext? context;
  
  @override
  Future<void> init() async {
    models.app.addListener(_update);
  }

  void _update() {
    final message = models.app.conversationNotification;
    if (context == null) return;
    if (message == null) return;
    ScaffoldMessenger.of(context!).showMaterialBanner(
      MaterialBanner(
        content: ListTile(
          title: Text("New message from ${message.otherName}"),
          subtitle: Text(message.summary ?? "Tap to see details"),
        ),
        leading: CircleAvatar(
          radius: 48,
          backgroundImage: NetworkImage(message.otherImage),
        ),
        actions: [
          TextButton(
            child: const Text("Close"),
            onPressed: () => ScaffoldMessenger.of(context!).hideCurrentMaterialBanner(),
          ),
          TextButton(
            child: const Text("Reply"),
            onPressed: () {
              ScaffoldMessenger.of(context!).hideCurrentMaterialBanner();
              router.go("${Routes.messages}/${message.id}");
            },
          ),
        ],
        margin: EdgeInsets.zero,
        padding: const EdgeInsets.only(left: 16, top: 16),
        elevation: 8,
        forceActionsBelow: true,
      ),
    );
  }

  @override
  void dispose() {
    models.app.removeListener(_update);
    super.dispose();
  }
}

/// A shell page that wraps the given page with a [BottomNavigationBar].
class ShellPage extends ReactiveWidget<ShellViewModel> {
  /// The main body of the app.
  final Widget child;
  
  /// Creates the navigation page.
  const ShellPage(this.child);

  @override
  ShellViewModel createModel() => ShellViewModel();

  @override
  void initModel(BuildContext context, ShellViewModel model) => model.context = context;
  
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
  Widget build(BuildContext context, ShellViewModel model) => Scaffold(
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
