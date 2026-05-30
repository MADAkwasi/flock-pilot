import 'package:flock_pilot/core/navigation/app_shell.dart';
import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/ai_assistant/presentation/screens/ai_chat_screen.dart';
import 'package:flock_pilot/features/auth/presentation/screens/login_screen.dart';
import 'package:flock_pilot/features/auth/presentation/screens/registration_screen.dart';
import 'package:flock_pilot/features/batches/presentation/screens/batch_details_screen.dart';
import 'package:flock_pilot/features/batches/presentation/screens/batches_screen.dart';
import 'package:flock_pilot/features/batches/presentation/screens/feed_record_form.dart';
import 'package:flock_pilot/features/batches/presentation/screens/mortality_form.dart';
import 'package:flock_pilot/features/batches/presentation/screens/record_eggs_screen.dart';
import 'package:flock_pilot/features/batches/presentation/screens/vaccination_screen.dart';
import 'package:flock_pilot/features/feed/presentation/screen/feed_detail_screen.dart';
import 'package:flock_pilot/features/feed/presentation/screen/feed_management_screen.dart';
import 'package:flock_pilot/features/home/presentation/screens/home_screen.dart';
import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_1.dart';
import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_2.dart';
import 'package:flock_pilot/features/settings/presentation/screens/settings.dart';
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
        path: RouteNames.aiAssistant,
        builder: (context, state) => const AiChatScreen(),
      ),

      GoRoute(
        path: RouteNames.recordEggs,
        builder: (context, state) => const RecordEggsScreen(),
      ),

      GoRoute(
        path: RouteNames.recordFeed,
        builder: (context, state) => const FeedBatchScreen(),
      ),

      GoRoute(
        path: RouteNames.mortality,
        builder: (context, state) => const MortalityScreen(),
      ),

      GoRoute(
        path: RouteNames.vaccination,
        builder: (context, state) => const VaccinationScreen(),
      ),

      GoRoute(
        path: RouteNames.batchDetails,
        builder: (context, state) {
          final batchId = state.pathParameters['batchId'];

          return BatchDetailScreen(batchId: batchId!);
        },
      ),

      GoRoute(
        path: RouteNames.feedDetails,
        builder: (context, state) {
          final feedId = state.pathParameters['feedId'];

          return FeedDetailScreen(feedId: feedId!);
        },
      ),

      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) {
          return AppShell(navigationShell: navigationShell);
        },

        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.home,
                builder: (context, state) => const HomeScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.batches,
                builder: (context, state) => BatchesScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.feedManagement,
                builder: (context, state) => const FeedManagementScreen(),
              ),
            ],
          ),

          StatefulShellBranch(
            routes: [
              GoRoute(
                path: RouteNames.settings,
                builder: (context, state) => const SettingsScreen(),
              ),
            ],
          ),
        ],
      ),
    ],
  );
}
