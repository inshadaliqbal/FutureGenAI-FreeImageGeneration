import 'package:flutter/material.dart';
import 'style.dart';

class MainButton extends StatelessWidget {
  Function buttonFunction;
  String? buttonText;

  MainButton(
      {super.key, required this.buttonFunction, @required this.buttonText});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Color(0xFF8A2BE2),
            Color(0xFFFF69B4)
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
          backgroundColor: Colors
              .transparent, // Ensure background is transparent to show gradient
        ),
        onPressed: () {
          buttonFunction();
        },
        child: Text(
          buttonText!,
          style: TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.w400,
            letterSpacing: 2,
          ),
        ),
      ),
    );
  }
}
