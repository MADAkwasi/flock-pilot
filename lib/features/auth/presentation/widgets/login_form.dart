import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

final _formKey = GlobalKey<FormState>();

class LoginForm extends StatelessWidget {
  LoginForm({super.key});

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      child: Column(
        children: [
          FormInputTextField(
            placeholder: 'Email Address',
            inputType: TextInputType.emailAddress,
            controller: emailController,
          ),
          FormInputTextField(
            placeholder: 'Password',
            isHidden: true,
            controller: passwordController,
          ),
          SizedBox(height: 20),
          PrimaryButton(
            label: 'Login',
            handlePress: () {
              context.go(RouteNames.dashboard);
            },
          ),
        ],
      ),
    );
  }
}
