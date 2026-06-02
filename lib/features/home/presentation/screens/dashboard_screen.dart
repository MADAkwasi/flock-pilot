import 'package:flock_pilot/features/home/presentation/widgets/farm_overview_chart.dart';
import 'package:flock_pilot/features/home/presentation/widgets/inventory_health_chart.dart';
import 'package:flock_pilot/provider/dashboard_provider.dart';
import 'package:flock_pilot/provider/farm_provider.dart';
import 'package:flock_pilot/shared/widgets/notification_alert_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class DashboardScreen extends ConsumerWidget {
  const DashboardScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final farm = ref.watch(farmProvider).farm;

    if (farm == null) {
      return const Scaffold(body: Center(child: Text("No farm found")));
    }

    final dashboard = ref.watch(dashboardProvider(farm.id));

    return Scaffold(
      appBar: AppBar(title: const Text("Farm Dashboard"), centerTitle: false),
      body: dashboard.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, _) => Center(child: Text(e.toString())),
        data: (d) {
          return ListView(
            padding: const EdgeInsets.all(16),
            children: [
              /// ================= KPI CARDS =================
              _SectionTitle("Overview"),

              const SizedBox(height: 10),

              GridView(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.3,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                children: [
                  _KpiCard(
                    icon: FontAwesomeIcons.dove,
                    label: "Birds",
                    value: d.overview.summary.totalBirds.toString(),
                    color: Colors.orange,
                  ),
                  _KpiCard(
                    icon: FontAwesomeIcons.egg,
                    label: "Eggs",
                    value: d.overview.production.totalEggs.toString(),
                    color: Colors.blue,
                  ),
                  _KpiCard(
                    icon: FontAwesomeIcons.sackDollar,
                    label: "Sales",
                    value: d.overview.finance.totalSales.toStringAsFixed(0),
                    color: Colors.green,
                  ),
                  _KpiCard(
                    icon: FontAwesomeIcons.skull,
                    label: "Mortality",
                    value: d.overview.flockHealth.totalMortality.toString(),
                    color: Colors.red,
                  ),
                ],
              ),

              const SizedBox(height: 25),

              /// ================= FINANCIAL CHART =================
              _SectionTitle("Financial Performance"),

              const SizedBox(height: 10),

              _CardContainer(
                child: FarmOverviewChart(
                  sales: d.overview.finance.totalSales,
                  expenses: d.overview.finance.totalExpenses,
                ),
              ),

              const SizedBox(height: 25),

              /// ================= INVENTORY =================
              _SectionTitle("Inventory Health"),

              const SizedBox(height: 10),

              _CardContainer(
                child: InventoryHealthChart(
                  totalItems: d.overview.inventory.totalItems,
                  lowStockItems: d.overview.inventory.lowStockItems.length,
                ),
              ),

              const SizedBox(height: 25),

              /// ================= SUMMARY =================
              _SectionTitle("AI Summary"),

              const SizedBox(height: 10),

              _CardContainer(
                child: Text(
                  d.summary,
                  style: Theme.of(context).textTheme.bodyMedium,
                ),
              ),

              const SizedBox(height: 25),

              /// ================= INSIGHTS =================
              _SectionTitle("Insights & Alerts"),

              const SizedBox(height: 10),

              ...d.insights.map(
                (i) => Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: NotificationAlertCard(
                    title: i.type,
                    message: i.message,
                    time: i.severity,
                    type: i.severity,
                    icon: FontAwesomeIcons.triangleExclamation,
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

class _SectionTitle extends StatelessWidget {
  final String text;

  const _SectionTitle(this.text);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      style: Theme.of(
        context,
      ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
    );
  }
}

class _CardContainer extends StatelessWidget {
  final Widget child;

  const _CardContainer({required this.child});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(16),
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: child,
    );
  }
}

class _KpiCard extends StatelessWidget {
  final FaIconData icon;
  final String label;
  final String value;
  final Color color;

  const _KpiCard({
    required this.icon,
    required this.label,
    required this.value,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(14),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: color.withValues(alpha: 0.08),
        border: Border.all(color: color.withValues(alpha: 0.2)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          FaIcon(icon, color: color, size: 18),
          const Spacer(),
          Text(
            value,
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),
          Text(label),
        ],
      ),
    );
  }
}
