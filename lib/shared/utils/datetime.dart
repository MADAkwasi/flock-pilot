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
