import 'package:flock_pilot/shared/models/flock_model.dart';
import 'package:flock_pilot/shared/utils/datetime.dart';
import 'package:flock_pilot/shared/utils/type_colors.dart';
import 'package:flutter/material.dart';

class BatchCard extends StatelessWidget {
  const BatchCard({required this.batch, required this.onTap, super.key});

  final FlockModel batch;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    final status = batch.status;
    final type = batch.flockType;

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
                      batch.name,
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
                      color: typeColor(type).withValues(alpha: 0.15),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      type.toUpperCase(),
                      style: TextStyle(
                        color: typeColor(type),
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
                      color: statusColor(status),
                    ),
                  ),
                  const SizedBox(width: 6),
                  Text(
                    status,
                    style: TextStyle(
                      color: statusColor(status),
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
                  _statItem("Birds", batch.currentCount.toString()),
                  _statItem("Age", formatFlockAge(batch.startDate)),
                  _statItem(
                    "Feed",
                    "${batch.feedConsumed.toStringAsFixed(2)}kg",
                  ),
                  if (batch.eggsLaid > 0)
                    _statItem("Eggs", batch.eggsLaid.toString()),
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
      crossAxisAlignment: CrossAxisAlignment.center,
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
