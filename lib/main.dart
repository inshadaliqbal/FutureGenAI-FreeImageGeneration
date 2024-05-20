import 'package:flutter/material.dart';
import 'package:futuregenai/welcome_page.dart';

void main() {
  runApp(const FutureGenAI());
}

class FutureGenAI extends StatelessWidget {
  const FutureGenAI({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: WelcomePage(),
    );
  }
}
