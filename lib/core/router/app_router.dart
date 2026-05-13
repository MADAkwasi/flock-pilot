import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/auth/presentation/screens/login_screen.dart';
import 'package:flock_pilot/features/auth/presentation/screens/registration_screen.dart';
import 'package:flock_pilot/features/dashboard/presentation/screens/dashboard_screen.dart';
import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_1.dart';
import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_2.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: RouteNames.onboarding1,
    routes: [
      GoRoute(
        path: RouteNames.onboarding1,
        builder: (context, state) => const WelcomeScreen1(),
      ),
      GoRoute(
        path: RouteNames.onboarding2,
        builder: (context, state) => const WelcomeScreen2(),
      ),
      GoRoute(
        path: RouteNames.register,
        builder: (context, state) => const RegistrationScreen(),
      ),
      GoRoute(
        path: RouteNames.login,
        builder: (context, state) => const LoginScreen(),
      ),
      GoRoute(
        path: RouteNames.dashboard,
        builder: (context, state) => const DashboardScreen(),
      ),
    ],
  );
}
