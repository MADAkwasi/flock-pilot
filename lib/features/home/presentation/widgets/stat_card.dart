import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class StatCard extends StatelessWidget {
  const StatCard({
    required this.icon,
    required this.cardName,
    required this.statFigure,
    required this.cardColor,
    this.trendValue,
    super.key,
  });

  final Widget icon;
  final String cardName;
  final String statFigure;
  final double? trendValue;
  final Color cardColor;

  @override
  Widget build(BuildContext context) {
    final hasTrend = trendValue != null;
    final isPositive = (trendValue ?? 0) >= 0;

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: cardColor,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          /// ================= TOP ROW =================
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.15),
                  shape: BoxShape.circle,
                ),
                child: IconTheme(
                  data: const IconThemeData(color: Colors.white, size: 18),
                  child: icon,
                ),
              ),

              if (hasTrend)
                Container(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10,
                    vertical: 6,
                  ),
                  decoration: BoxDecoration(
                    color: isPositive
                        ? Colors.green.withValues(alpha: 0.15)
                        : Colors.red.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      FaIcon(
                        isPositive
                            ? FontAwesomeIcons.arrowTrendUp
                            : FontAwesomeIcons.arrowTrendDown,
                        size: 12,
                        color: isPositive
                            ? Colors.greenAccent
                            : Colors.redAccent,
                      ),
                      const SizedBox(width: 5),
                      Text(
                        '${trendValue!.toStringAsFixed(1)}%',
                        style: TextStyle(
                          color: isPositive
                              ? Colors.greenAccent
                              : Colors.redAccent,
                          fontWeight: FontWeight.w600,
                          fontSize: 12,
                        ),
                      ),
                    ],
                  ),
                ),
            ],
          ),

          const Spacer(),

          /// ================= VALUE =================
          Text(
            statFigure,
            style: Theme.of(context).textTheme.headlineMedium?.copyWith(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),

          const SizedBox(height: 4),

          /// ================= LABEL =================
          Text(
            cardName,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Colors.white.withValues(alpha: 0.75),
            ),
          ),
        ],
      ),
    );
  }
}
