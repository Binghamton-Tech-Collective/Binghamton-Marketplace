import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:btc_market/data.dart";

import "src/pages/seller_profile.dart";
import "src/pages/shell.dart";
import "src/pages/product.dart";
import "src/pages/products.dart";
import "src/pages/editors/product.dart";
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
      builder: (context, state, shell) => Title(
        title: state.topRoute?.name ?? "ShopBing",
        color: Colors.green,
        child: ShellPage(shell),
      ),
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.products,
              name: "All products",
              builder: (context, state) => ProductsPage(),
              routes: [
                GoRoute(
                  path: "create",
                  name: "List a product",
                  builder: (context, state) => ProductEditor(),
                ),
                GoRoute(
                  path: ":id",
                  name: "View product",
                  builder: (context, state) =>
                      ProductPage(state.pathParameters["id"] as ProductID),
                  // Uncomment this to allow users to edit their profile
                  // routes: [
                  //   GoRoute(
                  //     path: "edit",
                  //     builder: (context, state) =>
                  //         ProductEditor(id: state.pathParameters["id"]),
                  //   ),
                  // ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.messages,
              name: Routes.messages,
              builder: (context, state) => const Placeholder(),
            ),
          ],
        ),
        StatefulShellBranch(routes: [
          GoRoute(
            path: Routes.sellers,
            name: "View sellers",
            builder: (context, state) => const Placeholder(),
            routes: [
              GoRoute(
                path: "create",
                name: "Create a seller profile",
                builder: (context, state) => SellerProfileEditor(),
              ),
              GoRoute(
                path: ":id",
                name: "View seller",
                builder: (context, state) => SellerProfilePage(state.pathParameters["id"] as SellerID),
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
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              name: Routes.profile,
              builder: (context, state) => const Placeholder(),
            ),
          ],
        ),
      ],
    ),
  ],
);
