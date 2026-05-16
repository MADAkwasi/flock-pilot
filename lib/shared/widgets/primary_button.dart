import 'package:flutter/material.dart';

class PrimaryButton extends StatelessWidget {
  const PrimaryButton({
    required this.label,
    required this.handlePress,
    this.bgColor,
    this.icon,
    super.key,
  });

  final Icon? icon;
  final String label;
  final VoidCallback handlePress;
  final Color? bgColor;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5),
      child: SizedBox(
        width: double.infinity,
        child: ElevatedButton.icon(
          style: ElevatedButton.styleFrom(backgroundColor: bgColor),
          onPressed: handlePress,
          icon: icon,
          label: Text(label),
        ),
      ),
    );
  }
}
