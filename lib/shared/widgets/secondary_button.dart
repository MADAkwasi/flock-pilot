import 'package:flock_pilot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.label,
    required this.handlePress,
    this.color = AppColors.primary,
    this.icon,
    super.key,
  });

  final String label;
  final Icon? icon;
  final Color color;
  final VoidCallback handlePress;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: handlePress,
          icon: icon,

          label: Text(label),
        ),
      ),
    );
  }
}
