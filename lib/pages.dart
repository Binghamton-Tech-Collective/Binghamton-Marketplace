import "package:btc_market/src/pages/sellers.dart";
import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:btc_market/data.dart";

import "src/pages/conversation.dart";
import "src/pages/seller_profile.dart";
import "src/pages/seller_profile_cta.dart";
import "src/pages/shell.dart";
import "src/pages/product.dart";
import "src/pages/products.dart";
import "src/pages/conversations.dart";

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
                  builder: (context, state) => const ProductEditor(),
                ),
                GoRoute(
                  path: ":id",
                  name: "View product",
                  builder: (context, state) => ProductPage(state.pathParameters["id"] as ProductID),
                  routes: [
                    GoRoute(
                      path: "edit",
                      name: "Edit a Product",
                      builder: (context, state) => ProductEditor(id: state.pathParameters["id"] as ProductID),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.messages,
              name: "All chats",
              builder: (context, state) => ConversationsPage(),
              routes: [
                GoRoute(
                  path: ":id",
                  name: "Chat with a seller",
                  builder: (context, state) => ConversationPage(
                    state.pathParameters["id"] as ConversationID,
                    state.extra as Conversation?,
                  ),
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.sellers,
              name: "View sellers",
              builder: (context, state) => SellersPage(),
              routes: [
                GoRoute(
                  path: "create",
                  name: "Create a seller profile",
                  builder: (context, state) => const SellerProfileEditor(),
                ),
              GoRoute(
                path: "no-profile",
                name: "No Seller Profile",
                builder: (context, state) => const SellerProfileCallToAction(),
              ),
                GoRoute(
                  path: ":id",
                  name: "View seller",
                  builder: (context, state) => SellerProfilePage(state.pathParameters["id"] as SellerID),
                  routes: [
                    GoRoute(
                      path: "edit",
                      name: "Edit profile",
                      builder: (context, state) => SellerProfileEditor(id: state.pathParameters["id"] as SellerID),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: Routes.profile,
              name: "My profile",
              builder: (context, state) => const Placeholder(),
            ),
          ],
        ),
      ],
    ),
  ],
);
