import 'package:flock_pilot/shared/models/flock_model.dart';
import 'package:flock_pilot/shared/utils/datetime.dart';
import 'package:flock_pilot/shared/utils/type_colors.dart';
import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({required this.batch, super.key});

  final FlockModel batch;

  Widget _stat(String icon, String value) {
    return Column(
      children: [
        Text(icon, style: const TextStyle(fontSize: 16)),
        const SizedBox(height: 4),
        Text(
          value,
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 0, vertical: 10),
      child: Align(
        alignment: Alignment.center,
        child: Container(
          width: double.infinity,
          height: double.infinity,
          padding: const EdgeInsets.all(14),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Batch name
              Text(
                batch.name,
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                  color: Colors.white,
                ),
              ),

              const Spacer(),

              // Status pill
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 4,
                ),
                decoration: BoxDecoration(
                  color: statusColor(batch.status).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: statusColor(batch.status)),
                ),
                child: Text(
                  batch.status,
                  style: TextStyle(
                    color: statusColor(batch.status),
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _stat("🐔", "${batch.currentCount}"),
                  _stat("📅", formatFlockAge(batch.startDate)),
                  _stat("🌾", "${batch.feedConsumed.toStringAsFixed(2)}kg"),
                  if (batch.eggsLaid > 0) _stat("🥚", "${batch.eggsLaid}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
