import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:flock_pilot/core/theme/app_colors.dart';

class ToastUtils {
  static void error(BuildContext context, String message) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    toastification.show(
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
      title: Text(
        message,
        style: TextStyle(
          color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
        ),
      ),
      icon: const Icon(Icons.error_outline, color: AppColors.error),
      borderSide: BorderSide(color: AppColors.error.withValues(alpha: 0.4)),
      type: ToastificationType.error,
      autoCloseDuration: const Duration(seconds: 4),
    );
  }
}
