import 'package:flutter/material.dart';

class Greeting extends StatelessWidget {
  const Greeting({required this.greetingText, super.key});

  final String greetingText;

  @override
  Widget build(BuildContext context) {
    return Text(greetingText, style: Theme.of(context).textTheme.titleMedium);
  }
}
