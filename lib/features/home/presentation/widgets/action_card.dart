import 'package:flutter/material.dart';

class ActionCard extends StatelessWidget {
  const ActionCard({
    required this.cardColor,
    required this.icon,
    required this.actionLabel,
    this.handleAction,
    super.key,
  });

  final Color cardColor;
  final Icon icon;
  final String actionLabel;
  final VoidCallback? handleAction;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: handleAction,

        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),

              margin: const EdgeInsets.symmetric(horizontal: 6, vertical: 8),

              padding: const EdgeInsets.all(18),

              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,

                  colors: [
                    cardColor.withValues(alpha: 0.95),
                    cardColor.withValues(alpha: 0.75),
                  ],
                ),

                borderRadius: BorderRadius.circular(24),

                border: Border.all(color: Colors.white.withValues(alpha: 0.08)),

                boxShadow: [
                  BoxShadow(
                    color: cardColor.withValues(alpha: 0.25),
                    blurRadius: 18,
                    offset: const Offset(0, 10),
                  ),
                ],
              ),

              child: AspectRatio(
                aspectRatio: 1,

                child: Center(
                  child: IconTheme(
                    data: const IconThemeData(color: Colors.white, size: 26),

                    child: icon,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 6),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 6),

              child: Text(
                actionLabel,
                textAlign: TextAlign.center,

                maxLines: 2,
                overflow: TextOverflow.ellipsis,

                style: Theme.of(context).textTheme.bodySmall?.copyWith(
                  fontWeight: FontWeight.w600,
                  height: 1.3,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
