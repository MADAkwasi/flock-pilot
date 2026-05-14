import 'package:flutter/material.dart';

class CarouselCard extends StatelessWidget {
  const CarouselCard({required this.batch, super.key});

  final Map<String, dynamic> batch;

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

  Color _statusColor(String status) {
    switch (status.toLowerCase()) {
      case "healthy":
        return Colors.green;
      case "active":
        return Colors.blue;
      case "monitoring":
        return Colors.orange;
      default:
        return Colors.grey;
    }
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
                batch["batchName"],
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
                  color: _statusColor(batch["status"]).withValues(alpha: 0.2),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: _statusColor(batch["status"])),
                ),
                child: Text(
                  batch["status"],
                  style: TextStyle(
                    color: _statusColor(batch["status"]),
                    fontSize: 12,
                  ),
                ),
              ),

              const SizedBox(height: 10),

              // Stats row
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  _stat("🐔", "${batch["birds"]}"),
                  _stat("📅", "${batch["ageWeeks"]}w"),
                  _stat("🌾", "${batch["feedPerDay"]}kg"),
                  if (batch["eggsPerDay"] > 0)
                    _stat("🥚", "${batch["eggsPerDay"]}"),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
