import 'package:flock_pilot/features/home/presentation/screens/dashboard_screen.dart';
import 'package:flock_pilot/features/home/presentation/screens/expense_history_screen.dart';
import 'package:flock_pilot/features/home/presentation/screens/expense_screen.dart';
import 'package:flock_pilot/features/home/presentation/screens/sales_screen.dart';
import 'package:flock_pilot/features/inventory/presentation/screens/inventory_screen.dart';
import 'package:go_router/go_router.dart';

import '../../features/ai_assistant/presentation/screens/ai_chat_screen.dart';
import '../../features/auth/presentation/screens/login_screen.dart';
import '../../features/auth/presentation/screens/registration_screen.dart';
import '../../features/batches/presentation/screens/batch_details_screen.dart';
import '../../features/batches/presentation/screens/batches_screen.dart';
import '../../features/batches/presentation/screens/feed_record_form.dart';
import '../../features/batches/presentation/screens/mortality_form.dart';
import '../../features/batches/presentation/screens/record_eggs_screen.dart';
import '../../features/batches/presentation/screens/vaccination_screen.dart';
import '../../features/feed/presentation/screen/feed_detail_screen.dart';
import '../../features/feed/presentation/screen/feed_management_screen.dart';
import '../../features/home/presentation/screens/home_screen.dart';
import '../../features/onboarding/presentation/screens/welcome_screen_1.dart';
import '../../features/onboarding/presentation/screens/welcome_screen_2.dart';
import '../../features/settings/presentation/screens/settings.dart';
import 'route_names.dart';
import '../../core/navigation/app_shell.dart';

class AppRouterConfig {
  static final routes = <RouteBase>[
    GoRoute(
      path: RouteNames.onboarding1,
      builder: (_, _) => const WelcomeScreen1(),
    ),

    GoRoute(
      path: RouteNames.onboarding2,
      builder: (_, _) => const WelcomeScreen2(),
    ),

    GoRoute(
      path: RouteNames.register,
      builder: (_, _) => const RegistrationScreen(),
    ),

    GoRoute(path: RouteNames.login, builder: (_, _) => const LoginScreen()),

    GoRoute(
      path: RouteNames.aiAssistant,
      builder: (_, _) => const AiChatScreen(),
    ),

    GoRoute(
      path: RouteNames.recordEggs,
      builder: (_, _) => const RecordEggsScreen(),
    ),

    GoRoute(
      path: RouteNames.recordFeed,
      builder: (_, _) => const FeedBatchScreen(),
    ),

    GoRoute(
      path: RouteNames.mortality,
      builder: (_, _) => const MortalityScreen(),
    ),

    GoRoute(
      path: RouteNames.vaccination,
      builder: (_, _) => const VaccinationScreen(),
    ),

    GoRoute(path: RouteNames.sales, builder: (_, _) => const SalesScreen()),

    GoRoute(
      path: RouteNames.expenses,
      builder: (_, _) => const ExpenseScreen(),
    ),

    GoRoute(
      path: RouteNames.expenseHistory,
      builder: (_, _) => const ExpenseHistoryScreen(),
    ),

    GoRoute(
      path: RouteNames.dashboard,
      builder: (_, _) => const DashboardScreen(),
    ),

    GoRoute(
      path: RouteNames.batchDetails,
      builder: (context, state) {
        final batchId = state.pathParameters['batchId']!;
        return BatchDetailScreen(batchId: batchId);
      },
    ),

    GoRoute(
      path: RouteNames.feedDetails,
      builder: (context, state) {
        final feedId = state.pathParameters['feedId']!;
        return FeedDetailScreen(feedId: feedId);
      },
    ),

    StatefulShellRoute.indexedStack(
      builder: (context, state, navShell) {
        return AppShell(navigationShell: navShell);
      },
      branches: [
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.home,
              builder: (_, _) => const HomeScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.batches,
              builder: (_, _) => BatchesScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.feedManagement,
              builder: (_, _) => const FeedManagementScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.inventory,
              builder: (_, _) => const InventoryScreen(),
            ),
          ],
        ),
        StatefulShellBranch(
          routes: [
            GoRoute(
              path: RouteNames.settings,
              builder: (_, _) => const SettingsScreen(),
            ),
          ],
        ),
      ],
    ),
  ];
}
