import 'package:flock_pilot/core/router/route_names.dart';
import 'package:flock_pilot/provider/auth_provider.dart';
import 'package:flock_pilot/shared/widgets/form_input_text_field.dart';
import 'package:flock_pilot/shared/widgets/primary_button.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

class RegistrationForm extends ConsumerStatefulWidget {
  const RegistrationForm({super.key});

  @override
  ConsumerState<RegistrationForm> createState() => _RegistrationFormState();
}

class _RegistrationFormState extends ConsumerState<RegistrationForm> {
  final _registrationFormKey = GlobalKey<FormState>();
  final fullNameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();
  final confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    fullNameController.dispose();
    emailController.dispose();
    passwordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  Future<void> _handleRegister() async {
    if (!_registrationFormKey.currentState!.validate()) return;

    final authNotifier = ref.read(authProvider.notifier);

    await authNotifier.register(
      fullNameController.text.trim(),
      emailController.text.trim(),
      passwordController.text.trim(),
    );

    final state = ref.read(authProvider);

    if (state.isAuthenticated && mounted) {
      context.go(RouteNames.home);
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);

    return Form(
      key: _registrationFormKey,
      child: Column(
        children: [
          FormInputTextField(
            label: 'Full Name',
            controller: fullNameController,
            validator: (value) =>
                value!.isEmpty ? 'Full name is required' : null,
          ),

          FormInputTextField(
            label: 'Email Address',
            inputType: TextInputType.emailAddress,
            controller: emailController,
            validator: (value) =>
                value!.contains('@') ? null : 'Enter valid email',
          ),

          FormInputTextField(
            label: 'Password',
            isHidden: true,
            controller: passwordController,
            validator: (value) =>
                value!.length < 8 ? 'Minimum 8 characters' : null,
          ),

          FormInputTextField(
            label: 'Confirm Password',
            isHidden: true,
            controller: confirmPasswordController,
            validator: (value) => value != passwordController.text
                ? 'Passwords do not match'
                : null,
          ),

          const SizedBox(height: 20),

          PrimaryButton(
            label: 'Create Account',
            handlePress: authState.isLoading ? null : _handleRegister,
            isLoading: authState.isLoading,
          ),
        ],
      ),
    );
  }
}
