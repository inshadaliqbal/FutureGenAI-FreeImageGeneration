
import 'package:flutter/material.dart';


BoxDecoration kMainTextFieldBoxDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Colors.black,
      offset: Offset(5, 5),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ],
);


ButtonStyle kMainButtonStyle = ButtonStyle(
  elevation: MaterialStateProperty.all(8.0),
  backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent.shade400),
  shape: MaterialStateProperty.all(
    RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(10),
      side: const BorderSide(width: 1, color: Colors.black),
    ),
  ),
  minimumSize: MaterialStateProperty.all(
    const Size(300, 50),
  ),
);


InputDecoration MainTextFieldInputDecoration(String? label) {
  return InputDecoration(
    labelText: label,
    labelStyle: const TextStyle(letterSpacing: 3),
    filled: true,
    fillColor: Colors.white,
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.black),
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
  );
}


BoxDecoration kMainButtonContainerDecoration = BoxDecoration(
  borderRadius: BorderRadius.circular(10),
  boxShadow: const [
    BoxShadow(
      color: Colors.black,
      offset: Offset(5, 5),
      blurRadius: 0,
      spreadRadius: 0,
    ),
  ],
);
