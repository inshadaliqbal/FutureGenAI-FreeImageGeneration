import 'package:flutter/material.dart';
import 'style.dart';

class MainButton extends StatelessWidget {
  MainButton({super.key, this.buttonColor,required this.buttonText, required this.buttonOnPress});
  final Color? buttonColor;
  final String? buttonText;
  Function buttonOnPress;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 10),
      decoration: kMainButtonContainerDecoration,
      child: TextButton(
        style: kMainButtonStyle.copyWith(backgroundColor: MaterialStatePropertyAll(buttonColor)),
        onPressed: () {
          buttonOnPress();
        },
        child: Text(
          buttonText!,
        ),
      ),
    );
  }
}