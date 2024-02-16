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
      selectedIndex: shell.currentIndex,
      onDestinationSelected: shell.goBranch,
      destinations: const [
        NavigationDestination(
          icon: Icon(Icons.home),
          label: "Home",
          ),
        NavigationDestination(
          icon: Icon(Icons.message),
          label: "Message",
          ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: "Profile",
          ),
        NavigationDestination(
          icon: Icon(Icons.notifications),
          label: "Notifications",
        ),
      ],
    ),
  );      
} 
