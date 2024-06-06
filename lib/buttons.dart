import 'package:flutter/material.dart';
import 'package:futuregenai/constants.dart';
import 'style.dart';

class MainButton extends StatelessWidget {
  final Function buttonFunction;
  final String? buttonText;

  MainButton({Key? key, required this.buttonFunction, @required this.buttonText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          colors: [
            Color(0xFF8A2BE2),
            Color(0xFFFF69B4),
          ], // Violet to pink gradient
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(30),
      ),
      child: TextButton(
        style: TextButton.styleFrom(
          padding: EdgeInsets.symmetric(horizontal: 15, vertical: 5),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
          backgroundColor:
          Colors.transparent, // Ensure background is transparent to show gradient
        ),
        onPressed: () {
          buttonFunction();
        },
        child: Text(
          buttonText!,
          style: kMainButtonTextStyle
        ),
      ),
    );
  }
}
