import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/features/feed/presentation/widgets/feed_card.dart';
import 'package:flock_pilot/features/feed/presentation/widgets/feed_summary_card.dart';
import 'package:flock_pilot/shared/widgets/action_card.dart';
import 'package:flock_pilot/shared/widgets/notification_alert_card.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FeedManagementScreen extends StatelessWidget {
  const FeedManagementScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView(
          padding: const EdgeInsets.all(20),
          children: [
            Text(
              'Feed Management',
              style: Theme.of(context).textTheme.headlineLarge,
            ),

            const SizedBox(height: 15),

            FeedSummaryCard(),

            const SizedBox(height: 28),

            Text(
              'Quick Actions',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            Row(
              spacing: 10,
              children: [
                ActionCard(
                  onTap: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.plus,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: 'Add Feed',
                  color: const Color(0xFF2E7D32),
                ),
                ActionCard(
                  onTap: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.clipboardList,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: 'Usage Logs',
                  color: const Color(0xFF1565C0),
                ),
                ActionCard(
                  onTap: () {},
                  icon: FaIcon(
                    FontAwesomeIcons.triangleExclamation,
                    color: Colors.white,
                    size: 18,
                  ),
                  label: 'Low Stock',
                  color: const Color(0xFFEF6C00),
                ),
              ],
            ),

            const SizedBox(height: 30),

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

            ...feedInventory.map(
              (feed) => FeedCard(
                isLowStock: feed['remainingKg'] < 300,
                feedName: feed['feedName'],
                batch: feed['batch'],
                usagePerDay: feed['usagePerDay'],
                remainingKg: feed['remainingKg'],
                stockPercentage: feed['stockPercentage'],
              ),
            ),

            const SizedBox(height: 24),

            Text(
              'Recent Feed Activity',
              style: Theme.of(
                context,
              ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
            ),

            const SizedBox(height: 16),

            ...feedActivities.map(
              (activity) => NotificationAlertCard(
                title: activity['title'],
                time: activity['time'],
                type: 'success',
                amount: activity['amount'],
                isNotification: false,
                icon: FontAwesomeIcons.clipboardCheck,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
