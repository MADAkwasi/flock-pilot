import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  const FloatingButton({
    required this.handlePress,
    required this.icon,
    super.key,
  });

  final VoidCallback handlePress;
  final Icon icon;

  @override
  Widget build(BuildContext context) {
    return FloatingActionButton(
      onPressed: handlePress,
      shape: CircleBorder(),
      child: icon,
    );
  }
}
