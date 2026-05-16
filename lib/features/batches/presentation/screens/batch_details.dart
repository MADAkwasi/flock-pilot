import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class BatchDetailScreen extends StatelessWidget {
  const BatchDetailScreen({required this.batchId, super.key});

  final String batchId;

  Map<String, dynamic> get batch {
    return batchData.firstWhere((item) => item['batchId'] == batchId);
  }

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'healthy':
        return Colors.green;
      case 'warning':
        return Colors.orange;
      case 'critical':
        return Colors.red;
      default:
        return Colors.blueGrey;
    }
  }

  Color _typeColor(String type) {
    switch (type.toLowerCase()) {
      case 'layers':
        return Colors.orange;
      case 'broilers':
        return Colors.blue;
      default:
        return Colors.grey;
    }
  }

  Widget _infoTile(
    BuildContext context, {
    required FaIconData icon,
    required String label,
    required String value,
  }) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 10,
            offset: const Offset(0, 6),
          ),
        ],
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
              icon,
              size: 18,
              color: Theme.of(context).colorScheme.primary,
            ),
          ),

          const SizedBox(width: 14),

          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label, style: Theme.of(context).textTheme.bodySmall),

                const SizedBox(height: 4),

                Text(
                  value,
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _actionButton(
    BuildContext context, {
    required FaIconData icon,
    required String label,
    required VoidCallback onTap,
    required Color color,
  }) {
    return Expanded(
      child: Material(
        color: color,
        borderRadius: BorderRadius.circular(20),
        clipBehavior: Clip.antiAlias,

        child: InkWell(
          onTap: onTap,

          child: Padding(
            padding: const EdgeInsets.symmetric(vertical: 18),

            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                FaIcon(icon, color: Colors.white, size: 20),

                const SizedBox(height: 10),

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
    );
  }

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
                                color: _typeColor(type).withValues(alpha: 0.18),

                                borderRadius: BorderRadius.circular(30),

                                border: Border.all(color: _typeColor(type)),
                              ),

                              child: Text(
                                type.toUpperCase(),

                                style: TextStyle(
                                  color: _typeColor(type),
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
                                color: _statusColor(
                                  status,
                                ).withValues(alpha: 0.18),

                                borderRadius: BorderRadius.circular(30),

                                border: Border.all(color: _statusColor(status)),
                              ),

                              child: Text(
                                status,

                                style: TextStyle(
                                  color: _statusColor(status),

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

                  const SizedBox(height: 18),

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
                      _infoTile(
                        context,
                        icon: FontAwesomeIcons.dove,
                        label: 'Total Birds',
                        value: batch['birds'].toString(),
                      ),

                      _infoTile(
                        context,
                        icon: FontAwesomeIcons.calendar,
                        label: 'Age',
                        value: '${batch['ageWeeks']} Weeks',
                      ),

                      _infoTile(
                        context,
                        icon: FontAwesomeIcons.wheatAwn,
                        label: 'Feed / Day',
                        value: '${batch['feedPerDay']} kg',
                      ),

                      _infoTile(
                        context,
                        icon: FontAwesomeIcons.egg,
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

                  const SizedBox(height: 18),

                  Row(
                    children: [
                      _actionButton(
                        context,
                        icon: FontAwesomeIcons.egg,
                        label: 'Record Eggs',
                        color: const Color(0xFF2B7FFF),
                        onTap: () {},
                      ),

                      const SizedBox(width: 12),

                      _actionButton(
                        context,
                        icon: FontAwesomeIcons.wheatAwn,
                        label: 'Add Feed',
                        color: const Color(0xFF00C853),
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 12),

                  Row(
                    children: [
                      _actionButton(
                        context,
                        icon: FontAwesomeIcons.syringe,
                        label: 'Vaccination',
                        color: const Color(0xFFFF9800),
                        onTap: () {},
                      ),

                      const SizedBox(width: 12),

                      _actionButton(
                        context,
                        icon: FontAwesomeIcons.skull,
                        label: 'Mortality',
                        color: const Color(0xFF8B1E1E),
                        onTap: () {},
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

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
