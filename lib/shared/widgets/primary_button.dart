import 'package:flock_pilot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.handlePress,
    this.bgColor = AppColors.primary,
    this.icon,
    super.key,
  });

  final Icon? icon;
  final String label;
  final VoidCallback handlePress;
  final Color bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          onPressed: handlePress,
          icon: icon,
          label: Text(label),
        ),
      ),
    );
  }
}
