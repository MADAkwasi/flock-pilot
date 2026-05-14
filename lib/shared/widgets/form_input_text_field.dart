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
          labelStyle: Theme.of(context).textTheme.labelLarge,
        ),
        keyboardType: inputType,
        obscureText: isHidden ?? false,
      ),
    );
  }
}
