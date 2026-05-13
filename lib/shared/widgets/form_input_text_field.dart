import 'package:flock_pilot/core/theme/app_theme.dart';
import 'package:flutter/material.dart';

class FormInputTextField extends StatelessWidget {
  const FormInputTextField({
    required this.placeholder,
    required this.controller,
    this.isHidden,
    this.inputType,
    super.key,
  });

  final String placeholder;
  final TextInputType? inputType;
  final bool? isHidden;
  final TextEditingController controller;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        decoration: InputDecoration(
          labelText: placeholder,
          labelStyle: TextStyle(color: AppColors.primary),
          focusColor: AppColors.secondary,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(10),
            borderSide: BorderSide(width: 2, color: AppColors.primary),
          ),
          border: OutlineInputBorder(borderRadius: BorderRadius.circular(10)),
        ),
        keyboardType: inputType,
        obscureText: isHidden ?? false,
      ),
    );
  }
}
