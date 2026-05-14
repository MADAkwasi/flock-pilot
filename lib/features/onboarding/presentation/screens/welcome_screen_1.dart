import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/features/onboarding/presentation/widgets/onboarding_assets.dart';
import 'package:flock_pilot/shared/widgets/floating_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class WelcomeScreen1 extends StatelessWidget {
  static const String id = 'welcome_screen_1';

  const WelcomeScreen1({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingButton(
        handlePress: () => context.go(RouteNames.onboarding2),
        icon: FaIcon(FontAwesomeIcons.arrowRight, size: 20),
      ),
      body: Center(
        child: OnboardingAssets(
          heading: 'Manage Your Farm Smarter',
          imageSrc: 'assets/images/onboarding-illustration-1.png',
          description:
              'Track your birds, feed usage, egg production, and daily farm activities all from one simple dashboard',
        ),
      ),
    );
  }
}
