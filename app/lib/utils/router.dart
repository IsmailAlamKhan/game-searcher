import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../providers/app_provider.dart';
import '../screens/game_details_screen.dart';
import '../screens/home_screen.dart';
import '../screens/search_screen.dart';
import '../screens/settings_screen.dart';
import '../screens/tags_screen.dart';

part 'router.g.dart';

final _shellNavigatorKey = GlobalKey<NavigatorState>();
final rootNavigatorKey = GlobalKey<NavigatorState>();

@riverpod
GoRouter appRouter(Ref ref) {
  return GoRouter(
    navigatorKey: rootNavigatorKey,
    observers: [_NavigatorObserver(ref)],
    routes: <RouteBase>[
      ShellRoute(
        navigatorKey: _shellNavigatorKey,
        builder: (BuildContext context, GoRouterState state, Widget child) {
          return HomeScreen(child: child);
        },
        routes: <RouteBase>[
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/',
            builder: (BuildContext context, GoRouterState state) {
              return const SearchScreen();
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/tags',
            builder: (BuildContext context, GoRouterState state) {
              return const TagsScreen();
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/settings',
            builder: (BuildContext context, GoRouterState state) {
              return const SettingsScreen();
            },
          ),
          GoRoute(
            parentNavigatorKey: _shellNavigatorKey,
            path: '/details/:gameId',
            builder: (BuildContext context, GoRouterState state) {
              final gameId = state.pathParameters['gameId']!;
              return GameDetailsScreen(gameId: gameId);
            },
          ),
        ],
      ),
    ],
  );
}

class _NavigatorObserver extends NavigatorObserver {
  final Ref ref;
  _NavigatorObserver(this.ref);

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    if (route.settings.name == null) return;
    ref.read(appControllerProvider.notifier).getIndexAccordingToRoute(route.settings.name!);
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    if (route.settings.name == null) return;
    ref.read(appControllerProvider.notifier).getIndexAccordingToRoute(route.settings.name!);
  }

  @override
  void didRemove(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didRemove(route, previousRoute);
    if (route.settings.name == null) return;
    ref.read(appControllerProvider.notifier).getIndexAccordingToRoute(route.settings.name!);
  }

  @override
  void didReplace({Route<dynamic>? newRoute, Route<dynamic>? oldRoute}) {
    super.didReplace(newRoute: newRoute, oldRoute: oldRoute);
    if (newRoute?.settings.name == null) return;
    ref.read(appControllerProvider.notifier).getIndexAccordingToRoute(newRoute!.settings.name!);
  }

  @override
  void didChangeTop(Route<dynamic> topRoute, Route<dynamic>? previousTopRoute) {
    super.didChangeTop(topRoute, previousTopRoute);
    if (topRoute.settings.name == null) return;
    ref.read(appControllerProvider.notifier).getIndexAccordingToRoute(topRoute.settings.name!);
  }
}
