import 'package:flock_pilot/shared/widgets/input_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';

class RegistrationForm extends StatelessWidget {
  const RegistrationForm({super.key});

  @override
  Widget build(BuildContext context) {
    return Form(
      child: Column(
        children: [
          InputField(placeholder: 'First Name'),
          InputField(placeholder: 'Last Name'),
          InputField(
            placeholder: 'Email Address',
            inputType: TextInputType.emailAddress,
          ),
          InputField(placeholder: 'Password (8+ Characters)', isHidden: true),
          SizedBox(height: 20),
          PrimaryButton(label: 'Create Account', handlePress: () {}),
        ],
      ),
    );
  }
}
