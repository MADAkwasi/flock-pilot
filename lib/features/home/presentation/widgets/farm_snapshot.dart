import 'package:flutter/material.dart';

class FarmSnapshotCard extends StatelessWidget {
  final int birds;
  final int flocks;
  final double mortality;
  final double profit;

  const FarmSnapshotCard({
    super.key,
    required this.birds,
    required this.flocks,
    required this.mortality,
    required this.profit,
  });

  @override
  Widget build(BuildContext context) {
    final isLoss = profit < 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        color: Theme.of(context).colorScheme.surface,
        border: Border.all(color: Colors.black.withValues(alpha: 0.05)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text("Farm Snapshot", style: Theme.of(context).textTheme.titleMedium),

          const SizedBox(height: 12),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              _item("Birds", birds.toString()),
              _item("Flocks", flocks.toString()),
              _item("Mortality", "${mortality.toStringAsFixed(1)}%"),
              _item(
                "Profit",
                "${isLoss ? '-' : '+'}${profit.abs().toStringAsFixed(0)}",
                color: isLoss ? Colors.red : Colors.green,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _item(String label, String value, {Color? color}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
        const SizedBox(height: 4),
        Text(
          value,
          style: TextStyle(fontWeight: FontWeight.bold, color: color),
        ),
      ],
    );
  }
}
