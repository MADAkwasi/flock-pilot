import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';

class InventoryHealthChart extends StatelessWidget {
  const InventoryHealthChart({
    required this.totalItems,
    required this.lowStockItems,
    super.key,
  });

  final int totalItems;
  final int lowStockItems;

  @override
  Widget build(BuildContext context) {
    final healthy = totalItems - lowStockItems;

    return Container(
      padding: const EdgeInsets.all(20),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(24),
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Inventory Health',
            style: Theme.of(
              context,
            ).textTheme.titleLarge?.copyWith(fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: 20),

          SizedBox(
            height: 220,
            child: PieChart(
              PieChartData(
                centerSpaceRadius: 55,
                sectionsSpace: 4,

                sections: [
                  PieChartSectionData(
                    value: healthy.toDouble(),
                    title: '$healthy Healthy',
                    radius: 55,
                  ),

                  PieChartSectionData(
                    value: lowStockItems.toDouble(),
                    title: '$lowStockItems Low',
                    radius: 55,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
