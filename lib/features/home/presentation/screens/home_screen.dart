import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/home/presentation/widgets/carousel.dart';
import 'package:flock_pilot/features/home/presentation/widgets/farm_snapshot.dart';
import 'package:flock_pilot/features/home/presentation/widgets/greeting.dart';
import 'package:flock_pilot/provider/dashboard_provider.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/provider/user_provider.dart';
import 'package:flock_pilot/shared/utils/datetime.dart';
import 'package:flock_pilot/shared/widgets/action_card.dart';
import 'package:flock_pilot/shared/enums/cards.dart';
import 'package:flock_pilot/features/home/presentation/widgets/farm_fallback_screen.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    final user = ref.watch(currentUserProvider);
    final farmState = ref.watch(farmProvider);

    if (farmState.isLoading) {
      return const Scaffold(body: Center(child: CircularProgressIndicator()));
    }

    if (farmState.error != null) {
      return FarmFallbackScreen(
        title: "Something went wrong",
        message: farmState.error!,
        icon: FontAwesomeIcons.triangleExclamation,
        onRetry: () => ref.invalidate(farmProvider),
      );
    }

    final farm = farmState.farm;

    if (farm == null) {
      return FarmFallbackScreen(
        title: "No farm found",
        message: "Create a farm to start tracking performance.",
        icon: FontAwesomeIcons.tractor,
        onRetry: () {},
      );
    }
    final dashboardAsync = ref.watch(dashboardProvider(farm.id));

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            // ================= HEADER =================
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Greeting(greetingText: getGreeting(context)),
                      Text(
                        user?.name ?? '',
                        style: Theme.of(context).textTheme.headlineLarge,
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const FaIcon(FontAwesomeIcons.bell),
                ),
                CircleAvatar(
                  child: Text(
                    "${user?.name.split(' ').first[0]}${user?.name.split(' ').last[0]}",
                  ),
                ),
              ],
            ),

            const SizedBox(height: 20),

            // ================= CAROUSEL =================
            SizedBox(
              height: 200,
              child: ClipRRect(
                borderRadius: BorderRadius.circular(20),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    Image.asset(
                      'assets/images/carousel.png',
                      fit: BoxFit.cover,
                    ),

                    Container(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.2),
                            Colors.black.withValues(alpha: 0.6),
                          ],
                        ),
                      ),
                    ),

                    Carousel(batchData: farm.flocks),
                  ],
                ),
              ),
            ),

            const SizedBox(height: 20),

            dashboardAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              ),

              error: (e, _) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Failed to load stats: $e",
                  style: const TextStyle(color: Colors.red),
                ),
              ),

              data: (dashboard) {
                final overview = dashboard.overview;

                return Column(
                  children: [
                    FarmSnapshotCard(
                      birds: overview.summary.totalBirds,
                      flocks: overview.summary.activeFlocks,
                      mortality: overview.summary.mortalityRate,
                      profit: overview.finance.profit,
                    ),

                    const SizedBox(height: 20),
                  ],
                );
              },
            ),

            const SizedBox(height: 10),

            // ================= QUICK ACTIONS =================
            Text(
              "Quick Actions",
              style: Theme.of(context).textTheme.headlineMedium,
            ),

            const SizedBox(height: 10),

            Row(
              spacing: 7,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: actionCards.map((action) {
                return Expanded(
                  child: ActionCard(
                    onTap: () => context.push(action['route']),
                    color: action['cardColor'],
                    icon: FaIcon(action['icon'], color: Colors.white),
                    label: action['actionLabel'],
                    textPosition: CardTextPosition.bottom,
                  ),
                );
              }).toList(),
            ),

            const SizedBox(height: 30),

            dashboardAsync.when(
              loading: () => const Padding(
                padding: EdgeInsets.symmetric(vertical: 20),
                child: Center(child: CircularProgressIndicator()),
              ),

              error: (e, _) => Padding(
                padding: const EdgeInsets.symmetric(vertical: 20),
                child: Text(
                  "Failed to load stats: $e",
                  style: const TextStyle(color: Colors.red),
                ),
              ),

              data: (dashboard) {
                return Container(
                  padding: const EdgeInsets.all(16),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(16),
                    color: Theme.of(context).colorScheme.surface,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "AI Insight",
                        style: Theme.of(context).textTheme.titleMedium,
                      ),

                      const SizedBox(height: 10),

                      Text(
                        dashboard.summary,
                        maxLines: 3,
                        overflow: TextOverflow.ellipsis,
                      ),
                    ],
                  ),
                );
              },
            ),

            const SizedBox(height: 20),

            // ================= DASHBOARD CTA =================
            PrimaryButton(
              label: 'View Full Dashboard',
              handlePress: () => context.push(RouteNames.dashboard),
              icon: const FaIcon(FontAwesomeIcons.chartLine),
            ),
          ],
        ),
      ),
    );
  }
}
