import 'package:flutter/material.dart';

class HeadingCard extends StatelessWidget {
  const HeadingCard({super.key});

  Widget _miniStat(BuildContext context, String label, String value) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          label,
          style: Theme.of(context).textTheme.labelMedium?.copyWith(
            color: Colors.white.withValues(alpha: 0.7),
          ),
        ),

        const SizedBox(height: 4),

        Text(
          value,
          style: Theme.of(context).textTheme.titleMedium?.copyWith(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(16),

      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Theme.of(context).colorScheme.primary,
            Theme.of(context).brightness == Brightness.dark
                ? Color(0xFF1B5E20)
                : Color(0xFF061D2C),
          ],
        ),

        borderRadius: BorderRadius.circular(24),

        border: Border.all(color: Colors.white.withValues(alpha: 0.08)),

        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.08),
            blurRadius: 18,
            offset: const Offset(0, 10),
          ),
        ],
      ),

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // ================= TOP SECTION =================
          Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // LEFT TEXT
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Total Birds',
                      style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: Colors.white.withValues(alpha: 0.8),
                        fontWeight: FontWeight.w500,
                      ),
                    ),

                    const SizedBox(height: 6),

                    Text(
                      '1,230',
                      style: Theme.of(context).textTheme.headlineMedium
                          ?.copyWith(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            letterSpacing: -1,
                          ),
                    ),
                  ],
                ),
              ),

              // RIGHT PLACEHOLDER (for chart)
              Container(
                height: 60,
                width: 60,
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.08),
                  borderRadius: BorderRadius.circular(16),
                ),
                child: const Center(
                  child: Icon(Icons.pie_chart_outline, color: Colors.white),
                ),
              ),
            ],
          ),

          const SizedBox(height: 18),

          // ================= BOTTOM STATS =================
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),

            decoration: BoxDecoration(
              color: Colors.white.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(16),
            ),

            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _miniStat(context, 'Broilers', '600'),
                _miniStat(context, 'Layers', '630'),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
