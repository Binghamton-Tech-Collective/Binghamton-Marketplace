import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "src/pages/editors/seller_profile.dart";

import "src/pages/notifications.dart";
import "src/pages/profile.dart";
import "src/pages/shell.dart";

/// All the routes in the app.
class Routes {
  /// The products route.
  static const products = "/products";
  /// The profile route.
  static const sellerProfile = "/seller-profile";
  /// The notifications route.
  static const notifications = "/notifications";
  /// The messages route.
  static const messages = "/messages";
  /// The route to create a new seller profile.
  /// 
  /// This isn't the actual route used in the URL, just in the code.
  static const createSellerProfile = "_create_seller_profile";
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
            path: Routes.sellerProfile,
            name: Routes.sellerProfile,
            builder: (context, state) => ProfilePage(),
            routes: [
              GoRoute(
                path: "create",
                name: Routes.createSellerProfile,
                builder: (context, state) => SellerProfileEditor(),
              ),
              // Uncomment this to enable users to edit their profile
              // GoRoute(
              //   path: ":id",
              //   builder: (context, state) => SellerProfileEditor(id: state.pathParameters["id"]!),
              // ),
            ],
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
