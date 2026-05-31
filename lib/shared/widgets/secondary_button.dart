import 'package:flock_pilot/core/theme/app_colors.dart';
import 'package:flutter/material.dart';

class SecondaryButton extends StatelessWidget {
  const SecondaryButton({
    required this.label,
    required this.handlePress,
    this.isLoading = false,
    this.color = AppColors.primary,
    this.icon,
    super.key,
  });

  final String label;
  final Icon? icon;
  final Color color;
  final VoidCallback handlePress;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5.0),
      child: SizedBox(
        width: double.infinity,
        child: OutlinedButton.icon(
          onPressed: handlePress,
          icon: icon,

          label: isLoading
              ? const SizedBox(
                  height: 20,
                  width: 20,
                  child: CircularProgressIndicator(strokeWidth: 2),
                )
              : Text(label),
        ),
      ),
    );
  }
}
