import 'package:flock_pilot/core/navigation/app_shell.dart';
import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/auth/presentation/screens/login_screen.dart';
import 'package:flock_pilot/features/auth/presentation/screens/registration_screen.dart';
import 'package:flock_pilot/features/batches/presentation/screens/batches_screen.dart';
import 'package:flock_pilot/features/home/presentation/screens/home_screen.dart';
import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_1.dart';
import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_2.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.onboarding1,

    routes: [
      // =========================
      // Onboarding
      // =========================
      GoRoute(
        path: RouteNames.onboarding1,
        builder: (context, state) => const WelcomeScreen1(),
      ),

      GoRoute(
        path: RouteNames.onboarding2,
        builder: (context, state) => const WelcomeScreen2(),
      ),

      // =========================
      // Auth
      // =========================
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegistrationScreen(),
      ),

      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),

      // =========================
      // Bottom Navigation Shell
      // =========================
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },

        branches: [
          // =========================
          // Home Branch
          // =========================
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // =========================
          // Batches Branch
          // =========================
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.batches,
                builder: (context, state) => const BatchesScreen(),
              ),
            ],
          ),

          // =========================
          // Feed Management Branch
          // =========================
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.management,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          // =========================
          // Settings Branch
          // =========================
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.settings,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
