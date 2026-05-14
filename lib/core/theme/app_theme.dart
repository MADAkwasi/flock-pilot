import 'package:flutter/material.dart';
import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  // =========================
  // Light Theme
  // =========================

  static ThemeData lightTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.light,

    scaffoldBackgroundColor: AppColors.background,

    colorScheme: const ColorScheme.light(
      primary: AppColors.primary,
      secondary: AppColors.secondary,
      surface: AppColors.surface,
      error: AppColors.error,
    ),

    dividerColor: AppColors.border,

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.textPrimary,
      ),

      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.textPrimary,
      ),

      bodyLarge: TextStyle(fontSize: 16, color: AppColors.textPrimary),

      bodyMedium: TextStyle(fontSize: 14, color: AppColors.textSecondary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,

        padding: const EdgeInsets.symmetric(vertical: 16),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.primary,

        side: const BorderSide(color: AppColors.primary, width: 1.5),

        padding: const EdgeInsets.symmetric(vertical: 16),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.surface,

      hintStyle: const TextStyle(color: AppColors.textSecondary),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(color: AppColors.border),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(color: AppColors.secondary, width: 2),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.primary,
      foregroundColor: Colors.white,
    ),

    iconTheme: const IconThemeData(color: AppColors.primary, size: 24),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: AppColors.secondary,
      unselectedItemColor: AppColors.textSecondary,
    ),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.surface,

      indicatorColor: AppColors.primary.withValues(alpha: 0.15),

      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: AppColors.primary,
            fontWeight: FontWeight.w600,
          );
        }

        return const TextStyle(color: AppColors.textSecondary);
      }),

      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.primary);
        }

        return const IconThemeData(color: AppColors.textSecondary);
      }),
    ),
  );

  // =========================
  // Dark Theme
  // =========================

  static ThemeData darkTheme = ThemeData(
    useMaterial3: true,

    brightness: Brightness.dark,

    scaffoldBackgroundColor: AppColors.darkBackground,

    colorScheme: const ColorScheme.dark(
      primary: AppColors.secondary,
      secondary: AppColors.darkSecondary,
      surface: AppColors.darkSurface,
      error: AppColors.error,
    ),

    dividerColor: AppColors.darkBorder,

    textTheme: const TextTheme(
      headlineLarge: TextStyle(
        fontSize: 32,
        fontWeight: FontWeight.bold,
        color: AppColors.darkTextPrimary,
      ),

      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: AppColors.darkTextPrimary,
      ),

      bodyLarge: TextStyle(fontSize: 16, color: AppColors.darkTextPrimary),

      bodyMedium: TextStyle(fontSize: 14, color: AppColors.darkTextSecondary),
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.darkSecondary,
        foregroundColor: Colors.white,

        padding: const EdgeInsets.symmetric(vertical: 16),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        foregroundColor: AppColors.darkSecondary,

        side: const BorderSide(color: AppColors.darkSecondary, width: 1.5),

        padding: const EdgeInsets.symmetric(vertical: 16),

        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      ),
    ),

    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: AppColors.darkSurface,

      hintStyle: const TextStyle(color: AppColors.darkTextSecondary),

      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(color: AppColors.darkBorder),
      ),

      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(10),

        borderSide: const BorderSide(color: AppColors.darkSecondary, width: 2),
      ),
    ),

    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: AppColors.darkSecondary,
      foregroundColor: Colors.white,
    ),

    iconTheme: const IconThemeData(color: AppColors.darkTextPrimary, size: 24),

    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: AppColors.darkSurface,

      indicatorColor: AppColors.darkSecondary.withValues(alpha: 0.2),

      labelTextStyle: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const TextStyle(
            color: AppColors.darkSecondary,
            fontWeight: FontWeight.w600,
          );
        }

        return const TextStyle(color: AppColors.darkTextSecondary);
      }),

      iconTheme: WidgetStateProperty.resolveWith((states) {
        if (states.contains(WidgetState.selected)) {
          return const IconThemeData(color: AppColors.darkSecondary);
        }

        return const IconThemeData(color: AppColors.darkTextSecondary);
      }),
    ),
  );
}
