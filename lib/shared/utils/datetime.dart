import 'package:flutter/material.dart';

String getGreeting(BuildContext context) {
  final hour = DateTime.now().hour;

  final isDarkMode = Theme.of(context).brightness == Brightness.dark;

  final moonEmoji = isDarkMode ? '🌕' : '🌑';

  if (hour < 12) {
    return 'Good Morning ⛅';
  } else if (hour < 17) {
    return 'Good Afternoon ☀️';
  } else {
    return 'Good Evening $moonEmoji';
  }
}

String formatFlockAge(DateTime startDate) {
  final totalDays = DateTime.now().difference(startDate).inDays;

  final weeks = totalDays ~/ 7;
  final days = totalDays % 7;

  if (weeks == 0) {
    return '$days ${days == 1 ? 'day' : 'days'}';
  }

  if (days == 0) {
    return '$weeks ${weeks == 1 ? 'week' : 'weeks'}';
  }

  return '$weeks ${weeks == 1 ? 'week' : 'weeks'}, '
      '$days ${days == 1 ? 'day' : 'days'}';
}

int calculateFlockAgeInWeeks(DateTime startDate) {
  final now = DateTime.now();
  final difference = now.difference(startDate).inDays;

  return (difference / 7).floor();
}
