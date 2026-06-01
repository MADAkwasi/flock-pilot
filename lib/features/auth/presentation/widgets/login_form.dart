import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class LoginForm extends ConsumerStatefulWidget {
  const LoginForm({super.key});

  @override
  ConsumerState<LoginForm> createState() => _LoginFormState();
}

class _LoginFormState extends ConsumerState<LoginForm> {
  final _loginFormKey = GlobalKey<FormState>();
  late final TextEditingController emailController;
  late final TextEditingController passwordController;

  @override
  void initState() {
    super.initState();
    emailController = TextEditingController();
    passwordController = TextEditingController();
  }

  @override
  void dispose() {
    emailController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  Future<void> handleLogin() async {
    if (!_loginFormKey.currentState!.validate()) return;

    await ref
        .read(authProvider.notifier)
        .login(
          email: emailController.text.trim(),
          password: passwordController.text.trim(),
        );
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Form(
      key: _loginFormKey,
      child: Column(
        children: [
          FormInputTextField(
            label: 'Email Address',
            inputType: TextInputType.emailAddress,
            controller: emailController,
            validator: (value) {
              if (value == null || value.trim().isEmpty) {
                return 'Email is required';
              }

              final emailRegex = RegExp(r'^[^@]+@[^@]+\.[^@]+');

              if (!emailRegex.hasMatch(value.trim())) {
                return 'Enter a valid email';
              }
              return null;
            },
          ),

          FormInputTextField(
            label: 'Password',
            isHidden: true,
            controller: passwordController,
            validator: (value) {
              if (value == null || value.isEmpty) {
                return 'Password is required';
              }

              if (value.length < 6) {
                return 'Password must be at least 6 characters';
              }

              return null;
            },
          ),

          const SizedBox(height: 20),

          PrimaryButton(
            label: 'Login',
            isLoading: authState.isLoading,
            handlePress: authState.isLoading ? null : handleLogin,
          ),

          if (authState.user == null && authState.isLoading == false)
            const SizedBox.shrink(),
        ],
      ),
    );
  }
}
