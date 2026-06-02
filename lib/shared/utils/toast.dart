import 'package:flutter/material.dart';
import 'package:toastification/toastification.dart';
import 'package:flock_pilot/core/theme/app_colors.dart';

class ToastUtils {
  static void error(BuildContext context, String message) {
    _show(
      context,
      message,
      type: ToastificationType.error,
      icon: Icons.error_outline,
      color: AppColors.error,
    );
  }

  static void success(BuildContext context, String message) {
    _show(
      context,
      message,
      type: ToastificationType.success,
      icon: Icons.check_circle_outline,
      color: Colors.green,
    );
  }

  static void info(BuildContext context, String message) {
    _show(
      context,
      message,
      type: ToastificationType.info,
      icon: Icons.info_outline,
      color: Colors.blue,
    );
  }

  static void _show(
    BuildContext context,
    String message, {
    required ToastificationType type,
    required IconData icon,
    required Color color,
  }) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    toastification.show(
      context: context,
      type: type,
      backgroundColor: isDark ? AppColors.darkSurface : AppColors.surface,
      title: Text(
        message,
        style: TextStyle(
          color: isDark ? AppColors.darkTextPrimary : AppColors.textPrimary,
        ),
      ),
      icon: Icon(icon, color: color),
      borderSide: BorderSide(color: color.withValues(alpha: 0.4)),
      autoCloseDuration: const Duration(seconds: 4),
    );
  }
}
