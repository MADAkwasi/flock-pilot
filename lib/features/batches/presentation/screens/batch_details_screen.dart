import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/shared/widgets/action_card.dart';
import 'package:flock_pilot/shared/utils/type_colors.dart';
import 'package:flock_pilot/shared/widgets/summary_tiles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class BatchDetailScreen extends StatelessWidget {
  const BatchDetailScreen({required this.batchId, super.key});

  final String batchId;

  Map<String, dynamic> get batch {
    return batchData.firstWhere((item) => item['batchId'] == batchId);
  }

  List<Map<String, dynamic>> get filteredActions {
    return batchQuickActions.where((action) {
      if (batch['type'] == 'broiler' &&
          action['label'].toString().contains('Eggs')) {
        return false;
      }
      return true;
    }).toList();
  }

  bool get isOdd => filteredActions.length % 2 != 0;

  List<Map<String, dynamic>> get gridItems => isOdd
      ? filteredActions.sublist(0, filteredActions.length - 1)
      : filteredActions;

  @override
  Widget build(BuildContext context) {
    final status = batch['status'];
    final type = batch['type'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 260,
            pinned: true,
            elevation: 0,

            backgroundColor: Theme.of(context).scaffoldBackgroundColor,

            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
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
                                color: statusColor(
                                  status,
                                ).withValues(alpha: 0.18),

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
                          batch['batchName'],

                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          '${batch['birds']} birds • ${batch['ageWeeks']} weeks old',

                          style: Theme.of(context).textTheme.bodyLarge
                              ?.copyWith(
                                color: Colors.white.withValues(alpha: 0.9),
                              ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),

          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

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
                        value: batch['birds'].toString(),
                      ),

                      SummaryTiles(
                        icon: FaIcon(
                          FontAwesomeIcons.calendar,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: 'Age',
                        value: '${batch['ageWeeks']} Weeks',
                      ),

                      SummaryTiles(
                        icon: FaIcon(
                          FontAwesomeIcons.wheatAwn,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: 'Feed / Day',
                        value: '${batch['feedPerDay']} kg',
                      ),

                      SummaryTiles(
                        icon: FaIcon(
                          FontAwesomeIcons.egg,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: 'Eggs / Day',
                        value: '${batch['eggsPerDay']}',
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  Text(
                    'Management Actions',

                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
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
                            icon: FaIcon(
                              action['icon'],
                              color: Colors.white,
                              size: 20,
                            ),
                            label: action['label'],
                            color: action['color'],
                            onTap: () => context.push(action["route"]),
                          );
                        }).toList(),
                      ),

                      if (isOdd)
                        Padding(
                          padding: const EdgeInsets.only(bottom: 20),
                          child: ActionCard(
                            icon: FaIcon(
                              filteredActions.last['icon'],
                              color: Colors.white,
                              size: 20,
                            ),
                            label: filteredActions.last['label'],
                            color: filteredActions.last['color'],
                            onTap: () =>
                                context.push(filteredActions.last["route"]),
                          ),
                        ),
                    ],
                  ),

                  Container(
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

                              child: const Icon(
                                Icons.lightbulb,
                                color: Colors.orange,
                              ),
                            ),

                            const SizedBox(width: 12),

                            Text(
                              'FlockPilot AI Insight',

                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(fontWeight: FontWeight.bold),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Text(
                          'Your feed consumption increased by 12% this week. Consider reviewing feeding schedules to reduce wastage.',

                          style: Theme.of(context).textTheme.bodyMedium,
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 40),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
