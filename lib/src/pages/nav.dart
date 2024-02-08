import "package:btc_market/src/pages/productPage.dart";
import "package:btc_market/src/pages/profile.dart";
import "package:btc_market/src/pages/notificationPage.dart";

import 'package:flutter/material.dart';

class Nav extends StatefulWidget{
  @override
  _NavState createState() => _NavState();
}

class _NavState extends State<Nav>{
  int idx = 0;
  List<Widget> _widgetOptions = <Widget> [
    Text('Home'),
    Text('Message'),
    Text('List Product'),
    ProfilePage(),
    Text('Notifications'),
  ];

void _onItemTap(int index){
  setState(() {
    idx = index;
  });
}
  @override
  Widget build(BuildContext context){
    final ThemeData theme = Theme.of(context);
    return Scaffold(
      body: Center(
        child: _widgetOptions.elementAt(idx),
      ),
      bottomNavigationBar: NavigationBar(
        selectedIndex: idx,
        onDestinationSelected: (int index){
          setState(() {
            idx = index;
          });
        },
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
              label: "Notifications",
            )
        ],
      ),

    );
  }
      
} 
