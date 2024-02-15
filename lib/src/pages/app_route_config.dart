import "package:btc_market/src/pages/notifications.dart";
import "package:btc_market/src/pages/profile.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

/// Class for router
class MyAppRouter{
  MyAppRouter._();

  /// Static string variable set as the home route
  static String initR = '/home';

  /// Go Router Configuration
  static final GoRouter router = GoRouter(
    initialLocation: initR,
    routes: [
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) => Scaffold(
            bottomNavigationBar: navigationShell,
        ),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: "/home",
                builder: (context, state) => NotificationsPage(),
              ),
              GoRoute(
                path: "/profile",
                builder: (context, state) => ProfilePage(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
