import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NotificationAlertCard extends StatelessWidget {
  const NotificationAlertCard({
    required this.title,
    required this.message,
    required this.time,
    required this.type,
    required this.icon,
    super.key,
  });

  final String title;
  final String message;
  final String time;
  final String type;
  final FaIconData icon;

  Color _notificationColor() {
    switch (type) {
      case 'success':
        return Colors.green;

      case 'warning':
        return Colors.orange;

      case 'danger':
        return Colors.red;

      case 'info':
        return Colors.blue;

      default:
        return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    final accentColor = _notificationColor();

    return Container(
      margin: const EdgeInsets.only(bottom: 14),

      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: Theme.of(context).cardColor,
        borderRadius: BorderRadius.circular(20),

        border: Border.all(color: accentColor.withValues(alpha: 0.15)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.04),
            blurRadius: 12,
            offset: const Offset(0, 6),
          ),
        ],
      ),

      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // =========================
          // Icon
          // =========================
          Container(
            padding: const EdgeInsets.all(12),

            decoration: BoxDecoration(
              color: accentColor.withValues(alpha: 0.12),
              shape: BoxShape.circle,
            ),

            child: FaIcon(icon, color: accentColor, size: 18),
          ),

          const SizedBox(width: 14),

          // =========================
          // Content
          // =========================
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Top Row
                Row(
                  children: [
                    Expanded(
                      child: Text(
                        title,
                        style: Theme.of(context).textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.bold),
                      ),
                    ),

                    Container(
                      width: 10,
                      height: 10,

                      decoration: BoxDecoration(
                        color: accentColor,
                        shape: BoxShape.circle,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 6),

                // Message
                Text(
                  message,
                  style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                    height: 1.4,
                    color: Theme.of(
                      context,
                    ).textTheme.bodyMedium?.color?.withValues(alpha: 0.7),
                  ),
                ),

                const SizedBox(height: 12),

                // Footer
                Row(
                  children: [
                    const FaIcon(
                      FontAwesomeIcons.clock,
                      size: 12,
                      color: Colors.grey,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      time,
                      style: Theme.of(
                        context,
                      ).textTheme.labelMedium?.copyWith(color: Colors.grey),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
