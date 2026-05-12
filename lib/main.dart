import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_1.dart';
import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_2.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: WelcomeScreen1.id,
      routes: {
        WelcomeScreen1.id: (context) => const WelcomeScreen1(),
        WelcomeScreen2.id: (context) => const WelcomeScreen2(),
      },
    );
  }
}
