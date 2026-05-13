import 'package:flock_pilot/core/constants/app_constants.dart';
import 'package:flock_pilot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class OnboardingAssets extends StatelessWidget {
  const OnboardingAssets({
    required this.heading,
    this.description,
    required this.imageSrc,
    super.key,
  });

  final String heading;
  final String? description;
  final String imageSrc;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Image.asset(imageSrc),
          SizedBox(height: 20),
          Text(
            heading,
            style: kAppHeadingTextStyle,
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 5),
          Text(
            description ?? '',
            textAlign: TextAlign.center,
            style: TextStyle(color: AppColors.textSecondary),
          ),
        ],
      ),
    );
  }
}
