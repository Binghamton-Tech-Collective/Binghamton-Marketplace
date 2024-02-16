import "package:flutter/material.dart";

import "profile.dart";

/// The navigation page, allows switching between other pages.
class NavPage extends StatefulWidget{
  @override
  NavPageState createState() => NavPageState();
}

/// The state for the navigation page.
class NavPageState extends State<NavPage>{
  /// THe index of the currently selected page.
  int idx = 0;
  /// The body widget for each option.
  final List<Widget> _widgetOptions = <Widget> [
    const Text("Home"),
    const Text("Message"),
    const Text("List Product"),
    ProfilePage(),
    const Text("Watchlist"),
  ];

void _onItemTap(int index){
  setState(() {
    idx = index;
  });
}
  @override
  Widget build(BuildContext context) => Scaffold(
    body: Center(
      child: _widgetOptions.elementAt(idx),
    ),
    bottomNavigationBar: NavigationBar(
      selectedIndex: idx,
      onDestinationSelected: _onItemTap,
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
          icon: Icon(Icons.add_box),
          label: "List Item",
          ),
        NavigationDestination(
          icon: Icon(Icons.person),
          label: "Profile",
          ),
        NavigationDestination(
          icon: Icon(Icons.notifications),
          label: "Watchlist",
        ),
      ],
    ),
  );      
} 
