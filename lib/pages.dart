import "package:flutter/material.dart";
import "package:go_router/go_router.dart";

import "package:btc_market/data.dart";
import "package:btc_market/models.dart";

import "src/pages/conversation.dart";
import "src/pages/sellers.dart";
import "src/pages/seller_profile.dart";
import "src/pages/seller_profile_cta.dart";
import "src/pages/shell.dart";
import "src/pages/product.dart";
import "src/pages/products.dart";
import "src/pages/conversations.dart";
import "src/pages/login.dart";
import "src/pages/coming_soon.dart";
import "src/pages/user_profile.dart";

import "src/pages/editors/product.dart";
import "src/pages/editors/seller_profile.dart";

/// All the routes in the app.
class Routes {
  /// The products route.
  static const products = "/products";

  /// The route to list a product.
  static const sellers = "/sellers";

  /// The sell something route.
  static const sell = "/sell";

  /// The messages route.
  static const messages = "/messages";

  /// The user's profile route.
  static const profile = "/my-profile";

  /// The route for the login page.
  static const login = "/login";
  
  /// The route for the page when a user needs a seller profile.
  static const noSeller = "no-profile";

  /// All the routes on the bottom nav bar. Used in [ShellPage].
  static const branches = [products, sellers, sell, messages, profile];
}

extension on Object? {
  T? safeCast<T>() => this is T ? (this as T) : null;
}

/// Redirects users to the login page if they are not signed in.
String? authRedirect(BuildContext context, GoRouterState state) =>  
  (!models.user.isSignedIn && state.matchedLocation != Routes.login) 
    ? "${Routes.login}?redirect=${state.matchedLocation}" : null;

/// Redirects users to the No Seller Profile page if they don't have a profile.
String? sellerRedirect(BuildContext context, GoRouterState state) =>  
  models.user.isSeller ? null : "${Routes.sellers}/${Routes.noSeller}";

/// The [GoRouter] that controls the routing logic for the app.
final GoRouter router = GoRouter(
  redirect: authRedirect,
  initialLocation: Routes.products,
  routes: [
    GoRoute(
      path: "/",
      redirect: (_, __) => Routes.products,
    ),
    GoRoute(
      path: "/login",
      builder: (context, state) => LoginPage(redirect: state.uri.queryParameters["redirect"]),
    ),
    ShellRoute(
      pageBuilder: (context, state, child) => NoTransitionPage(
        child: Title(
          title: state.topRoute?.name ?? "ShopBing",
          color: Colors.green,
          child: ShellPage(child),
        ),
      ),
      routes: [
        GoRoute(
          path: Routes.products,
          name: "All products",
          pageBuilder: (context, state) => NoTransitionPage(child: ProductsPage()),
          routes: [
            GoRoute(
              path: "create",
              name: "List a product",
              redirect: sellerRedirect,
              builder: (context, state) => const ProductEditor(),
            ),
            GoRoute(
              path: ":id",
              name: "View product",
              builder: (context, state) => ProductPage(
                id: state.pathParameters["id"] as ProductID,
                product: state.extra.safeCast<Product>(),
              ),
              routes: [
                GoRoute(
                  path: "edit",
                  name: "Edit a Product",
                  redirect: sellerRedirect,
                  builder: (context, state) => ProductEditor(
                    id: state.pathParameters["id"] as ProductID,
                    initialProduct: state.extra.safeCast<Product>(),
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: Routes.sellers,
          name: "View sellers",
          pageBuilder: (context, state) => NoTransitionPage(child: SellersPage()),
          routes: [
            GoRoute(
              path: "create",
              name: "Create a seller profile",
              builder: (context, state) => const SellerProfileEditor(),
            ),
            GoRoute(
              path: Routes.noSeller,
              name: "No Seller Profile",
              builder: (context, state) => const SellerProfileCallToAction(),
            ),
            GoRoute(
              path: ":id",
              name: "View seller",
              builder: (context, state) => SellerProfilePage(
                id: state.pathParameters["id"] as SellerID, 
                profile: state.extra.safeCast<SellerProfile>(),
              ),
              routes: [
                GoRoute(
                  path: "edit",
                  name: "Edit profile",
                  redirect: sellerRedirect,
                  builder: (context, state) => SellerProfileEditor(
                    id: state.pathParameters["id"] as SellerID,
                    profile: state.extra.safeCast<SellerProfile>(),
                  ),
                ),
              ],
            ),
          ],
        ),
        GoRoute(
          path: Routes.sell,
          name: "Sell a product",
          redirect: sellerRedirect,
          pageBuilder:(context, state) => const NoTransitionPage(child: ProductEditor()),
        ),
        GoRoute(
          path: Routes.messages,
          name: "All chats",
          pageBuilder: (context, state) => NoTransitionPage(child: ConversationsPage()),
          routes: [
            GoRoute(
              path: ":id",
              name: "Chat with a seller",
              builder: (context, state) => ConversationPage(
                state.pathParameters["id"] as ConversationID,
                state.extra.safeCast<Conversation>(),
              ),
            ),
          ],
        ),
        GoRoute(
          path: Routes.profile,
          name: "My profile",
          pageBuilder: (context, state) => NoTransitionPage(
            child: UserProfilePage(id: null, profile: null),
          ),
        ),
      ],
    ),
  ],
);
