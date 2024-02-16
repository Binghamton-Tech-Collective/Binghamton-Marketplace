import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "src/pages/notifications.dart";
import "src/pages/profile.dart";
import "src/pages/shell.dart";

/// All the routes in the app.
class Routes {
  /// The products route.
  static const products = "/products";
  /// The profile route.
  static const profile = "/profile";
  /// The notifications route.
  static const notifications = "/notifications";
  /// The messages route.
  static const messages = "/messages";
}

/// The [GoRouter] that controls the routing logic for the app.
final GoRouter router = GoRouter(
  initialLocation: Routes.products,
  routes: [
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => ShellPage(shell),
      branches: [
        StatefulShellBranch(routes: [
            GoRoute(
              path: Routes.products,
              name: Routes.products,
              builder: (context, state) => NotificationsPage(),
            ),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.messages,
            name: Routes.messages,
            builder: (context, state) => const Placeholder(),
          ),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.profile,
            name: Routes.profile,
            builder: (context, state) => ProfilePage(),
          ),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.notifications,
            name: Routes.notifications,
            builder: (context, state) => const Placeholder(),
          ),
        ],),
      ],
    ),
  ],
);
