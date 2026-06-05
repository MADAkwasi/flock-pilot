import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/provider/batch_provider.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/shared/models/flock_model.dart';
import 'package:flock_pilot/shared/utils/datetime.dart';
import 'package:flock_pilot/shared/utils/type_colors.dart';
import 'package:flock_pilot/shared/widgets/action_card.dart';
import 'package:flock_pilot/shared/widgets/summary_tiles.dart';
import 'package:flutter/material.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BatchDetailScreen extends ConsumerWidget {
  const BatchDetailScreen({required this.batchId, super.key});

  final String batchId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farmState = ref.watch(farmProvider);

    if (farmState.farm == null) {
      return const Center(child: CircularProgressIndicator());
    }

    final flockAsync = ref.watch(
      batchProvider((farmId: farmState.farm!.id, batchId: batchId)),
    );

    return Scaffold(
      body: flockAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text("Error: $e")),
        data: (flock) {
          final status = flock.status;
          final type = flock.flockType;

          final actions = batchQuickActions.where((action) {
            if (type == 'BROILER' &&
                action['label'].toString().contains('Eggs')) {
              return false;
            }

            return true;
          }).toList();

          final isOdd = (actions.length % 2) != 0;

          final gridItems = isOdd
              ? actions.sublist(0, actions.length - 1)
              : actions;

          return CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 260,
                pinned: true,
                flexibleSpace: FlexibleSpaceBar(
                  background: _Header(flock: flock, status: status, type: type),
                ),
              ),

              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(left: 20, right: 20, top: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Overview',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 1.5,
                            ),
                        children: [
                          SummaryTiles(
                            icon: FaIcon(
                              FontAwesomeIcons.dove,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            label: 'Total Birds',
                            value: flock.currentCount.toString(),
                          ),
                          SummaryTiles(
                            icon: FaIcon(
                              FontAwesomeIcons.calendar,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            label: 'Age',
                            value:
                                "${calculateFlockAgeInWeeks(flock.startDate)} Weeks",
                          ),
                          SummaryTiles(
                            icon: FaIcon(
                              FontAwesomeIcons.wheatAwn,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            label: 'Feed Consumed',
                            value:
                                "${flock.feedConsumed.toStringAsFixed(2)} kg",
                          ),
                          SummaryTiles(
                            icon: FaIcon(
                              FontAwesomeIcons.egg,
                              size: 18,
                              color: Theme.of(context).colorScheme.primary,
                            ),
                            label: 'Eggs Laid',
                            value: flock.eggsLaid.toString(),
                          ),
                        ],
                      ),

                      const SizedBox(height: 10),

                      Text(
                        'Management Actions',
                        style: Theme.of(context).textTheme.titleLarge?.copyWith(
                          fontWeight: FontWeight.bold,
                        ),
                      ),

                      GridView(
                        shrinkWrap: true,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              crossAxisSpacing: 14,
                              mainAxisSpacing: 14,
                              childAspectRatio: 1.5,
                            ),
                        children: gridItems.map((action) {
                          return ActionCard(
                            icon: FaIcon(action['icon'], color: Colors.white),
                            label: action['label'],
                            color: action['color'],
                            onTap: () => context.push(action["route"]),
                          );
                        }).toList(),
                      ),

                      if (isOdd)
                        ActionCard(
                          icon: FaIcon(
                            actions.last['icon'],
                            color: Colors.white,
                          ),
                          label: actions.last['label'],
                          color: actions.last['color'],
                          onTap: () => context.push(actions.last["route"]),
                        ),

                      const SizedBox(height: 30),

                      _InsightCard(flock: flock),

                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}

class _Header extends StatelessWidget {
  final FlockModel flock;
  final String status;
  final String type;

  const _Header({
    required this.flock,
    required this.status,
    required this.type,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Image.asset('assets/images/carousel.png', fit: BoxFit.cover),

        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,

              colors: [
                Colors.black.withValues(alpha: 0.2),
                Colors.black.withValues(alpha: 0.75),
              ],
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.fromLTRB(20, 120, 20, 30),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,

            mainAxisAlignment: MainAxisAlignment.end,

            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),

                    decoration: BoxDecoration(
                      color: typeColor(type).withValues(alpha: 0.18),

                      borderRadius: BorderRadius.circular(30),

                      border: Border.all(color: typeColor(type)),
                    ),

                    child: Text(
                      type.toUpperCase(),

                      style: TextStyle(
                        color: typeColor(type),
                        fontWeight: FontWeight.bold,
                        fontSize: 12,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 12,
                      vertical: 5,
                    ),

                    decoration: BoxDecoration(
                      color: statusColor(status).withValues(alpha: 0.18),

                      borderRadius: BorderRadius.circular(30),

                      border: Border.all(color: statusColor(status)),
                    ),

                    child: Text(
                      status,

                      style: TextStyle(
                        color: statusColor(status),

                        fontWeight: FontWeight.bold,

                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 16),

              Text(
                flock.name,

                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 8),

              Text(
                '${flock.currentCount} birds • ${formatFlockAge(flock.startDate)} weeks old',

                style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  color: Colors.white.withValues(alpha: 0.9),
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _InsightCard extends StatelessWidget {
  final FlockModel flock;

  const _InsightCard({required this.flock});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(18),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(22),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,

        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(10),

                decoration: BoxDecoration(
                  color: Colors.orange.withValues(alpha: 0.12),

                  borderRadius: BorderRadius.circular(14),
                ),

                child: const Icon(Icons.lightbulb, color: Colors.orange),
              ),

              const SizedBox(width: 12),

              Text(
                'FlockPilot AI Insight',

                style: Theme.of(
                  context,
                ).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.bold),
              ),
            ],
          ),

          const SizedBox(height: 16),

          MarkdownBody(
            data: flock.insight ?? '',
            styleSheet: MarkdownStyleSheet(
              p: Theme.of(context).textTheme.bodyMedium,
            ),
          ),
        ],
      ),
    );
  }
}
