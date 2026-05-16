import 'package:flutter/material.dart';

class FormInputTextField extends StatelessWidget {
  const FormInputTextField({
    required this.label,
    this.placeholder,
    required this.controller,
    this.isHidden,
    this.inputType,
    this.icon,
    this.maxLines = 1,
    super.key,
  });

  final String? placeholder;
  final String label;
  final TextInputType? inputType;
  final int? maxLines;
  final bool? isHidden;
  final TextEditingController controller;
  final Icon? icon;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: TextFormField(
        controller: controller,
        maxLines: maxLines,
        decoration: InputDecoration(
          hintText: placeholder,
          labelText: label,
          labelStyle: Theme.of(context).textTheme.labelLarge,
          alignLabelWithHint: true,
          prefixIcon: icon != null
              ? Center(widthFactor: 1, heightFactor: 1, child: icon)
              : null,
        ),
        keyboardType: inputType,
        obscureText: isHidden ?? false,
      ),
    );
  }
}
