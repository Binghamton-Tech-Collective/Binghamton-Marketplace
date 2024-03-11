import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:btc_market/data.dart";

import "src/pages/notifications.dart";
import "src/pages/seller_profile.dart";
import "src/pages/shell.dart";
import "src/pages/product.dart";

import "src/pages/editors/seller_profile.dart";

/// All the routes in the app.
class Routes {
  /// The products route.
  static const products = "/products";
  /// The profile route.
  static const sellers = "/sellers";
  /// The messages route.
  static const messages = "/messages";
  /// The user's profile route.
  static const profile = "/my-profile";
}

/// The [GoRouter] that controls the routing logic for the app.
final GoRouter router = GoRouter(
  initialLocation: Routes.products,
  routes: [
    GoRoute(
      path: "/",
      redirect: (context, state) => Routes.products,
    ),
    StatefulShellRoute.indexedStack(
      builder: (context, state, shell) => ShellPage(shell),
      branches: [
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.products,
            name: Routes.products,
            builder: (context, state) => NotificationsPage(),
            routes: [
              GoRoute(
                path: ":id",
                builder: (context, state) => ProductPage(state.pathParameters["id"] as ProductID),
              ),
            ],
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
            path: Routes.sellers,
            name: Routes.sellers,
            builder: (context, state) => const Placeholder(),
            routes: [
              GoRoute(
                path: "create",
                builder: (context, state) => SellerProfileEditor(),
              ),
              GoRoute(
                path: ":id",
                builder: (context, state) => SellerProfilePage(/* id: state.pathParameters["id"]! */),
                // Uncomment this to allow users to edit their profile
                // routes: [
                //   GoRoute(
                //     path: "edit",
                //     builder: (context, state) => SellerProfileEditor(id: state.pathParameters["id"]),
                //   ),
                // ]
              ),
            ],
          ),
        ],),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.profile,
            name: Routes.profile,
            builder: (context, state) => const Placeholder(),
          ),
        ],),
      ],
    ),
  ],
);
