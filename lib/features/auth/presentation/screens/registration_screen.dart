import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/core/theme/app_theme.dart';
import 'package:flock_pilot/features/auth/presentation/widgets/registration_form.dart';
import 'package:flock_pilot/shared/widgets/secondary_button.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';

class RegistrationScreen extends StatelessWidget {
  const RegistrationScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 20.0, horizontal: 25),
          child: ListView(
            children: [
              const Text(
                'Create Your FlockPilot Account',
                style: kAppHeadingTextStyle,
                textAlign: TextAlign.center,
              ),
              const Text(
                'Start managing your poultry farm with smart tracking, insights, and real-time flock monitoring.',
                textAlign: TextAlign.center,
                style: TextStyle(color: AppColors.textSecondary),
              ),
              const SizedBox(height: 30),
              RegistrationForm(),
              const Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or Register With',
                        style: TextStyle(color: AppColors.textSecondary),
                      ),
                    ),

                    Expanded(child: Divider()),
                  ],
                ),
              ),
              SecondaryButton(
                handlePress: () {},
                label: 'Continue with Google',
                icon: FaIcon(FontAwesomeIcons.google),
              ),
              SecondaryButton(
                handlePress: () {},
                label: 'Continue with Apple',
                icon: FaIcon(FontAwesomeIcons.apple),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text('Already have an account?'),
                  TextButton(
                    onPressed: () => context.push(RouteNames.login),
                    child: Text(
                      'Log in',
                      style: TextStyle(
                        color: AppColors.secondary,
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
