import 'package:flock_pilot/core/router/app_router_refresh_stream.dart';
import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router_config.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  final authNotifier = ref.read(authProvider.notifier);

  return GoRouter(
    initialLocation: RouteNames.onboarding1,

    refreshListenable: GoRouterRefreshStream(authNotifier.stream),

    redirect: (context, state) {
      final authState = ref.read(authProvider);

      final publicRoutes = [
        RouteNames.onboarding1,
        RouteNames.onboarding2,
        RouteNames.login,
        RouteNames.register,
      ];

      final isPublicRoute = publicRoutes.contains(state.matchedLocation);

      if (authState.isLoading) return null;

      if (!authState.isAuthenticated && !isPublicRoute) {
        return RouteNames.login;
      }

      if (authState.isAuthenticated &&
          (state.matchedLocation == RouteNames.login ||
              state.matchedLocation == RouteNames.register)) {
        return RouteNames.home;
      }

      return null;
    },

    routes: AppRouterConfig.routes,
  );
});
