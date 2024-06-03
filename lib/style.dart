
import 'package:flutter/material.dart';




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
    fillColor: Colors.black,
    border: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.white),
      borderRadius: BorderRadius.circular(20),
    ),
    enabledBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.white),
      borderRadius: BorderRadius.circular(30),
    ),
    focusedBorder: OutlineInputBorder(
      borderSide: const BorderSide(width: 1, color: Colors.white),
      borderRadius: BorderRadius.circular(10),
    ),
    contentPadding: const EdgeInsets.symmetric(horizontal: 10),
  );
}


BoxDecoration kMainButtonContainerDecoration = BoxDecoration(
  gradient: LinearGradient(
    colors: [
      Color(0xFF8A2BE2),
      Color(0xFFFF69B4)
    ], // Violet to pink gradient
    begin: Alignment.topLeft,
    end: Alignment.bottomRight,
  ),
  borderRadius: BorderRadius.circular(30),
);
