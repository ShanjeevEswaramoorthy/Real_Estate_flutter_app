import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:real_estate_app/ui/add_post_ui.dart';
import 'package:real_estate_app/ui/bottom_navigation_ui.dart';
import 'package:real_estate_app/ui/cache_image_ui.dart';

import '../ui/landing_screen_ui.dart';

final routerGlobalKey = GlobalKey<NavigatorState>(debugLabel: '/root');

final GoRouter goRouter =
    GoRouter(initialLocation: '/home', navigatorKey: routerGlobalKey, routes: [
  GoRoute(
    path: '/cache_image',
    name: '/cache_image',
    builder: (context, state) => const CacheImageUI(),
  ),
  StatefulShellRoute.indexedStack(
    branches: [
      StatefulShellBranch(routes: [
        GoRoute(
          path: '/home',
          name: '/home',
          builder: (context, state) => const LandingScreenUI(),
        ),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
          path: '/add-post',
          name: '/add-post',
          builder: (context, state) => const AddPostFormUi(),
        ),
      ]),
      StatefulShellBranch(routes: [
        GoRoute(
          path: '/profile',
          name: '/profile',
          builder: (context, state) => const SizedBox(),
        ),
      ]),
    ],
    builder: (context, state, navigationShell) => BottomNavigationUi(
      navigationShell: navigationShell,
    ),
  ),
]);
