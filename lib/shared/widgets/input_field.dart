import 'package:flock_pilot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class InputField extends StatelessWidget {
  const InputField({
    required this.placeholder,
    this.isHidden,
    this.inputType,
    super.key,
  });

  final String placeholder;
  final TextInputType? inputType;
  final bool? isHidden;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        decoration: InputDecoration(
          hintText: placeholder,
          focusColor: AppColors.secondary,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: AppColors.secondary),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        keyboardType: inputType,
        obscureText: isHidden ?? false,
      ),
    );
  }
}
