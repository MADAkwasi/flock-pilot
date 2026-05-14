import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    required this.icon,
    required this.cardName,
    required this.statFigure,
    required this.rateChange,
    required this.cardColor,
    super.key,
  });

  final Icon icon;
  final String cardName;
  final int statFigure;
  final double rateChange;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    final isPositive = rateChange >= 0;

    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.05),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(12),

                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),

                child: IconTheme(
                  data: const IconThemeData(color: Colors.white, size: 18),
                  child: icon,
                ),
              ),

              // Trend indicator
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 10,
                  vertical: 6,
                ),

                decoration: BoxDecoration(
                  color: isPositive
                      ? Colors.green.withValues(alpha: 0.15)
                      : Colors.red.withValues(alpha: 0.15),

                  borderRadius: BorderRadius.circular(30),
                ),

                child: Row(
                  children: [
                    FaIcon(
                      isPositive
                          ? FontAwesomeIcons.arrowTrendUp
                          : FontAwesomeIcons.arrowTrendDown,
                      size: 12,
                      color: isPositive ? Colors.greenAccent : Colors.redAccent,
                    ),

                    const SizedBox(width: 6),

                    Text(
                      '${rateChange.toStringAsFixed(1)}%',
                      style: Theme.of(context).textTheme.labelMedium?.copyWith(
                        fontWeight: FontWeight.w600,
                        color: isPositive
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),

          const Spacer(),

          // =========================
          // Main Stat
          // =========================
          Text(
            statFigure.toString(),
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              fontWeight: FontWeight.bold,
              color: Colors.white,
              letterSpacing: -1,
            ),
          ),

          const SizedBox(height: 6),

          Text(
            cardName,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}
