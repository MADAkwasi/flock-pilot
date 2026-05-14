import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/core/theme/app_colors.dart';
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
          padding: const EdgeInsets.only(top: 10, left: 25, right: 25),
          child: ListView(
            children: [
              Text(
                'Create Your FlockPilot Account',
                style: Theme.of(context).textTheme.headlineLarge,
                textAlign: TextAlign.center,
              ),
              Text(
                'Start managing your poultry farm with smart tracking, insights, and real-time flock monitoring.',
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 30),
              RegistrationForm(),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 15),
                child: Row(
                  children: [
                    Expanded(child: Divider()),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Text(
                        'Or Register With',
                        style: Theme.of(context).textTheme.bodyMedium,
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
