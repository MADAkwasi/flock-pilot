import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/shared/utils/type_colors.dart';
import 'package:flock_pilot/shared/widgets/notification_alert_card.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flock_pilot/shared/widgets/secondary_button.dart';
import 'package:flock_pilot/shared/widgets/summary_tiles.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedDetailScreen extends StatelessWidget {
  const FeedDetailScreen({required this.feedId, super.key});

  final String feedId;

  // ================= DUMMY FEED =================
  Map<String, dynamic> get feed {
    return feedInventory.firstWhere((feed) => feed['feedId'] == feedId);
  }

  @override
  Widget build(BuildContext context) {
    final status = feed['status'];

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ================= APP BAR =================
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            elevation: 0,

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

                            const SizedBox(width: 10),

                            Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 5,
                              ),

                              decoration: BoxDecoration(
                                color: Colors.blue.withValues(alpha: 0.15),
                                borderRadius: BorderRadius.circular(30),
                              ),

                              child: Text(
                                feed['type'].toUpperCase(),
                                style: const TextStyle(
                                  color: Colors.blue,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12,
                                ),
                              ),
                            ),
                          ],
                        ),

                        const SizedBox(height: 16),

                        Text(
                          feed['feedName'],
                          style: Theme.of(context).textTheme.headlineMedium
                              ?.copyWith(
                                color: Colors.white,
                                fontWeight: FontWeight.bold,
                              ),
                        ),

                        const SizedBox(height: 8),

                        Text(
                          '${feed['remainingKg']}kg remaining • ${feed['usagePerDay']}kg/day',
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

          // ================= BODY =================
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),

              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ================= OVERVIEW =================
                  Text(
                    'Feed Overview',
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
                          FontAwesomeIcons.box,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: 'Remaining',
                        value: '${feed['remainingKg']} kg',
                      ),

                      SummaryTiles(
                        icon: FaIcon(
                          FontAwesomeIcons.chartPie,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: 'Stock Level',
                        value: '${feed['stockPercentage']}%',
                      ),

                      SummaryTiles(
                        icon: FaIcon(
                          FontAwesomeIcons.truck,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: 'Supplier',
                        value: feed['supplier'],
                      ),

                      SummaryTiles(
                        icon: FaIcon(
                          FontAwesomeIcons.chartLine,
                          size: 18,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                        label: 'Usage / Day',
                        value: '${feed['usagePerDay']}kg',
                      ),
                    ],
                  ),

                  const SizedBox(height: 20),

                  // ================= ASSIGNED BATCH =================
                  Text(
                    'Assigned Batch',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(22),

                      border: Border.all(
                        color: Colors.white.withValues(alpha: 0.08),
                      ),
                    ),

                    child: Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.all(12),

                          decoration: BoxDecoration(
                            color: Theme.of(
                              context,
                            ).colorScheme.primary.withValues(alpha: 0.12),

                            borderRadius: BorderRadius.circular(14),
                          ),

                          child: FaIcon(
                            FontAwesomeIcons.dove,
                            color: Theme.of(context).colorScheme.primary,
                            size: 18,
                          ),
                        ),

                        const SizedBox(width: 14),

                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Currently Assigned To',
                                style: Theme.of(context).textTheme.bodySmall,
                              ),

                              const SizedBox(height: 4),

                              Text(
                                feed['batch'],
                                style: Theme.of(context).textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ================= DESCRIPTION =================
                  Text(
                    'Description',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 12),

                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(18),

                    decoration: BoxDecoration(
                      color: Theme.of(context).cardColor,
                      borderRadius: BorderRadius.circular(22),
                    ),

                    child: Text(
                      feed['description'],
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ),

                  const SizedBox(height: 28),

                  // ================= QUICK ACTIONS =================
                  Text(
                    'Quick Actions',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      Expanded(
                        child: PrimaryButton(
                          label: 'Restock',
                          handlePress: () {},
                          icon: FaIcon(FontAwesomeIcons.plus),
                        ),
                      ),

                      const SizedBox(width: 12),

                      Expanded(
                        child: SecondaryButton(
                          label: 'Edit Feed',
                          handlePress: () {},
                          icon: FaIcon(FontAwesomeIcons.pencil, size: 17),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // ================= RECENT ACTIVITY =================
                  Text(
                    'Recent Activity',
                    style: Theme.of(context).textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  const SizedBox(height: 18),

                  NotificationAlertCard(
                    title: 'Feed Restocked',
                    message: 'Added 100kg to ${feed['feedName']} inventory',
                    time: 'Today',
                    isNotification: false,
                    type: "success",
                    icon: FontAwesomeIcons.clockRotateLeft,
                    timeAlign: TimeAlignment.top,
                  ),

                  NotificationAlertCard(
                    title: 'Feed Dispensed',
                    message:
                        'Supplied ${feed['usagePerDay']}kg to ${feed['batch']}',
                    time: 'Yesterday',
                    isNotification: false,
                    type: "success",
                    icon: FontAwesomeIcons.clockRotateLeft,
                    timeAlign: TimeAlignment.top,
                  ),

                  NotificationAlertCard(
                    title: 'Stock Monitoring',
                    message: '${feed['stockPercentage']}% stock remaining',
                    time: '2 days ago',
                    isNotification: false,
                    type: "success",
                    icon: FontAwesomeIcons.clockRotateLeft,
                    timeAlign: TimeAlignment.top,
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
