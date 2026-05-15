import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedManagementScreen extends StatelessWidget {
  const FeedManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Feed Management',
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            SizedBox(height: 15),
            // ======================================
            // HEADER CARD
            // ======================================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                gradient: const LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Color(0xFF2E7D32), Color(0xFF1B5E20)],
                ),
                borderRadius: BorderRadius.circular(28),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withValues(alpha: 0.08),
                    blurRadius: 20,
                    offset: const Offset(0, 12),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Total Feed Stock',
                              style: Theme.of(context).textTheme.titleMedium
                                  ?.copyWith(
                                    color: Colors.white.withValues(alpha: 0.8),
                                    fontWeight: FontWeight.w500,
                                  ),
                            ),

                            const SizedBox(height: 8),

                            Text(
                              '4,320 kg',
                              style: Theme.of(context).textTheme.headlineMedium
                                  ?.copyWith(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    letterSpacing: -1,
                                  ),
                            ),
                          ],
                        ),
                      ),

                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: Colors.white.withValues(alpha: 0.12),
                          shape: BoxShape.circle,
                        ),
                        child: const FaIcon(
                          FontAwesomeIcons.wheatAwn,
                          color: Colors.white,
                          size: 28,
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 24),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      _miniStat(context, label: 'Today Usage', value: '180kg'),
                      _miniStat(
                        context,
                        label: 'Low Stock',
                        value: '2 Batches',
                      ),
                      _miniStat(context, label: 'Weekly Avg', value: '1.2T'),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 28),

            // ======================================
            // QUICK ACTIONS
            // ======================================
            Text(
              'Quick Actions',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Row(
              children: [
                _actionCard(
                  context,
                  icon: FontAwesomeIcons.plus,
                  label: 'Add Feed',
                  color: const Color(0xFF2E7D32),
                ),
                _actionCard(
                  context,
                  icon: FontAwesomeIcons.clipboardList,
                  label: 'Usage Logs',
                  color: const Color(0xFF1565C0),
                ),
                _actionCard(
                  context,
                  icon: FontAwesomeIcons.triangleExclamation,
                  label: 'Low Stock',
                  color: const Color(0xFFEF6C00),
                ),
              ],
            ),

            const SizedBox(height: 30),

            // ======================================
            // FEED INVENTORY
            // ======================================
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Feed Inventory',
                  style: Theme.of(
                    context,
                  ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
                ),

                TextButton(onPressed: () {}, child: const Text('See All')),
              ],
            ),

            const SizedBox(height: 14),

            ...feedInventory.map((feed) => _feedCard(context, feed, isDark)),

            const SizedBox(height: 24),

            // ======================================
            // RECENT ACTIVITY
            // ======================================
            Text(
              'Recent Feed Activity',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            ...feedActivities.map(
              (activity) => _activityCard(context, activity),
            ),
          ],
        ),
      ),

      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {},
        backgroundColor: const Color(0xFF2E7D32),
        icon: const FaIcon(FontAwesomeIcons.plus),
        label: const Text('Add Feed Record'),
      ),
    );
  }

  Widget _miniStat(
    BuildContext context, {
    required String label,
    required String value,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),
        const SizedBox(height: 4),
        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  Widget _actionCard(
    BuildContext context, {
    required FaIconData icon,
    required String label,
    required Color color,
  }) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 5),
        child: Material(
          color: color,
          borderRadius: BorderRadius.circular(22),
          clipBehavior: Clip.antiAlias,
          child: InkWell(
            onTap: () {},
            child: Padding(
              padding: const EdgeInsets.symmetric(vertical: 18),
              child: Column(
                children: [
                  Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: Colors.white.withValues(alpha: 0.14),
                      shape: BoxShape.circle,
                    ),
                    child: FaIcon(icon, color: Colors.white, size: 18),
                  ),

                  const SizedBox(height: 12),

                  Text(
                    label,
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _feedCard(
    BuildContext context,
    Map<String, dynamic> feed,
    bool isDark,
  ) {
    final lowStock = feed['remainingKg'] < 300;

    return Card(
      margin: const EdgeInsets.only(bottom: 14),
      elevation: 1,
      shadowColor: Colors.black.withValues(alpha: 0.04),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(22)),
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: () {},
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Column(
            children: [
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.all(14),
                    decoration: BoxDecoration(
                      color: lowStock
                          ? Colors.orange.withValues(alpha: 0.12)
                          : Colors.green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(18),
                    ),
                    child: FaIcon(
                      FontAwesomeIcons.wheatAwn,
                      color: lowStock ? Colors.orange : Colors.green,
                      size: 18,
                    ),
                  ),

                  const SizedBox(width: 14),

                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          feed['feedName'],
                          style: Theme.of(context).textTheme.titleMedium
                              ?.copyWith(fontWeight: FontWeight.bold),
                        ),

                        const SizedBox(height: 4),

                        Text(
                          'Used by ${feed['batch']} • ${feed['usagePerDay']}kg/day',
                          style: Theme.of(
                            context,
                          ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 6,
                    ),
                    decoration: BoxDecoration(
                      color: lowStock
                          ? Colors.orange.withValues(alpha: 0.12)
                          : Colors.green.withValues(alpha: 0.12),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      lowStock ? 'LOW' : 'GOOD',
                      style: TextStyle(
                        color: lowStock ? Colors.orange : Colors.green,
                        fontWeight: FontWeight.w700,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 18),

              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${feed['remainingKg']}kg remaining',
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      Text(
                        '${feed['stockPercentage']}%',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),

                  const SizedBox(height: 10),

                  ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: LinearProgressIndicator(
                      value: feed['stockPercentage'] / 100,
                      minHeight: 10,
                      backgroundColor: Colors.grey.withValues(alpha: 0.15),
                      color: lowStock ? Colors.orange : Colors.green,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _activityCard(BuildContext context, Map<String, dynamic> activity) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(18),
        border: Border.all(color: Colors.black.withValues(alpha: 0.04)),
      ),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xFF2E7D32).withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),
            child: const FaIcon(
              FontAwesomeIcons.clipboardCheck,
              size: 16,
              color: Color(0xFF2E7D32),
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  activity['title'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodyLarge?.copyWith(fontWeight: FontWeight.w600),
                ),

                const SizedBox(height: 4),

                Text(
                  activity['time'],
                  style: Theme.of(
                    context,
                  ).textTheme.bodySmall?.copyWith(color: Colors.grey),
                ),
              ],
            ),
          ),

          Text(
            activity['amount'],
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: const Color(0xFF2E7D32),
            ),
          ),
        ],
      ),
    );
  }
}

final List<Map<String, dynamic>> feedInventory = [
  {
    'feedName': 'Starter Mash',
    'batch': 'Broiler Batch B',
    'remainingKg': 240,
    'usagePerDay': 48,
    'stockPercentage': 24,
  },
  {
    'feedName': 'Layer Concentrate',
    'batch': 'Layer Batch A',
    'remainingKg': 760,
    'usagePerDay': 62,
    'stockPercentage': 78,
  },
  {
    'feedName': 'Grower Feed',
    'batch': 'Starter Batch D',
    'remainingKg': 530,
    'usagePerDay': 38,
    'stockPercentage': 54,
  },
];

final List<Map<String, dynamic>> feedActivities = [
  {
    'title': 'Added Starter Mash stock',
    'time': '10 mins ago',
    'amount': '+120kg',
  },
  {
    'title': 'Feed allocated to Layer Batch A',
    'time': '1 hour ago',
    'amount': '-48kg',
  },
  {
    'title': 'Daily feed usage logged',
    'time': 'Today • 6:30 AM',
    'amount': '-180kg',
  },
];
