import 'package:flutter/material.dart';

class BatchCard extends StatelessWidget {
  const BatchCard({required this.batch, required this.onTap, super.key});

  final Map<String, dynamic> batch;
  final VoidCallback onTap;

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case 'active':
        return Colors.green;
      case 'critical':
        return Colors.red;
      case 'monitoring':
        return Colors.orange;
      default:
        return Colors.grey;
    }
  }

  Color _typeColor(String type) {
    return type == 'layer' ? Colors.blue : Colors.deepOrange;
  }

  @override
  Widget build(BuildContext context) {
    final status = batch["status"];
    final type = batch["type"];

    return Card(
      elevation: 2,
      shadowColor: Colors.black.withValues(alpha: 0.05),
      color: Theme.of(context).cardColor,

      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),

      clipBehavior: Clip.antiAlias,

      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(18),

        child: Padding(
          padding: const EdgeInsets.all(16),

          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // ================= TOP ROW =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      batch["batchName"],
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),

                  Container(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 10,
                      vertical: 4,
                    ),
                    decoration: BoxDecoration(
                      color: _typeColor(type).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      type.toUpperCase(),
                      style: TextStyle(
                        color: _typeColor(type),
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 10),

              // ================= STATUS =================
              Row(
                children: [
                  Container(
                    width: 10,
                    height: 10,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _statusColor(status),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status,
                    style: TextStyle(
                      color: _statusColor(status),
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                ],
              ),

              const SizedBox(height: 14),

              // ================= STATS =================
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _statItem("Birds", batch["birds"].toString()),
                  _statItem("Age", "${batch["ageWeeks"]}w"),
                  _statItem("Feed", "${batch["feedPerDay"]}kg"),
                  if (batch["eggsPerDay"] > 0)
                    _statItem("Eggs", batch["eggsPerDay"].toString()),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _statItem(String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          value,
          style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 14),
        ),
        const SizedBox(height: 2),
        Text(label, style: const TextStyle(fontSize: 12, color: Colors.grey)),
      ],
    );
  }
}
