import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _formKey = GlobalKey<FormState>();

class RegistrationForm extends StatelessWidget {
  RegistrationForm({super.key});

  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormInputTextField(
            label: 'First Name',
            controller: firstNameController,
          ),
          FormInputTextField(
            label: 'Last Name',
            controller: lastNameController,
          ),
          FormInputTextField(
            label: 'Email Address',
            inputType: TextInputType.emailAddress,
            controller: emailController,
          ),
          FormInputTextField(
            label: 'Password',
            placeholder: 'Password (8+ Characters)',
            isHidden: true,
            controller: passwordController,
          ),
          FormInputTextField(
            label: 'Confirm Password',
            isHidden: true,
            controller: confirmPasswordController,
          ),
          SizedBox(height: 20),
          PrimaryButton(
            label: 'Create Account',
            handlePress: () => context.go(RouteNames.home),
          ),
        ],
      ),
    );
  }
}
