import 'package:flock_pilot/shared/enums/cards.dart';
import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  final Icon icon;
  final String label;
  final VoidCallback onTap;
  final Color color;
  final CardTextPosition? textPosition;

  const ActionCard({
    required this.icon,
    required this.label,
    required this.color,
    required this.onTap,
    this.textPosition = CardTextPosition.inside,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Material(
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
                    Container(
                      padding: const EdgeInsets.all(12),
                      decoration: BoxDecoration(
                        color: Colors.white.withValues(alpha: 0.14),
                        shape: BoxShape.circle,
                      ),
                      child: icon,
                    ),

                    if (textPosition == CardTextPosition.inside)
                      const SizedBox(height: 10),

                    if (textPosition == CardTextPosition.inside)
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

          SizedBox(height: 10),

          if (textPosition == CardTextPosition.bottom)
            Text(
              label,
              textAlign: TextAlign.center,

              maxLines: 2,
              overflow: TextOverflow.ellipsis,

              style: Theme.of(context).textTheme.bodySmall?.copyWith(
                fontWeight: FontWeight.w600,
                height: 1.3,
              ),
            ),
        ],
      ),
    );
  }
}
