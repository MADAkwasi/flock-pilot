import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'app_router_config.dart';
import 'route_names.dart';

final appRouterProvider = Provider<GoRouter>((ref) {
  return GoRouter(
    initialLocation: RouteNames.onboarding1,

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

      // 🔒 unauthenticated user trying to access protected route
      if (!authState.isAuthenticated && !isPublicRoute) {
        return RouteNames.login;
      }

      // ✅ authenticated user trying to access auth screens
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
