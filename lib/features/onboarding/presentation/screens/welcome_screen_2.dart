import 'package:flock_pilot/features/onboarding/presentation/screens/welcome_screen_1.dart';
import 'package:flock_pilot/features/onboarding/presentation/widgets/onboarding_assets.dart';
import 'package:flock_pilot/shared/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class WelcomeScreen2 extends StatelessWidget {
  static const String id = 'welcome_string_2';

  const WelcomeScreen2({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        handlePress: () => Navigator.pushNamed(context, WelcomeScreen1.id),
        icon: FaIcon(FontAwesomeIcons.arrowRight, size: 20),
      ),
      body: Center(
        child: OnboardingAssets(
          heading: 'Your Intelligent Farm Assistant',
          imageSrc: 'images/onboarding-illustration-2.png',
          description:
              'FlockPilot helps you make better farming decisions with smart alerts, analytics, and personalized guidance.',
        ),
      ),
    );
  }
}
