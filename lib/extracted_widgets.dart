import 'package:flutter/material.dart';
import 'style.dart';

class MainTextField extends StatelessWidget {
  Function changeFunction;
  String? label;
  final _formKey = GlobalKey<FormState>();

  MainTextField({super.key, required this.label, required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: kMainTextFieldBoxDecoration,
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            changeFunction(value);
          },
          textAlign: TextAlign.right,
          decoration: MainTextFieldInputDecoration(label),
          validator: _validateEmail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}

class MainTextFieldAPI extends StatelessWidget {
  Function changeFunction;
  String? label;
  final _formKey = GlobalKey<FormState>();

  MainTextFieldAPI({super.key, required this.label, required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: kMainTextFieldBoxDecoration,
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            changeFunction(value);
          },
          textAlign: TextAlign.right,
          decoration: MainTextFieldInputDecoration(label),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}


class MainTextFieldPassword extends StatelessWidget {
  Function changeFunction;
  String? label;
  final _formKey = GlobalKey<FormState>();

  MainTextFieldPassword(
      {super.key, required this.label, required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      decoration: kMainTextFieldBoxDecoration,
      child: Form(
        key: _formKey,
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            changeFunction(value);
          },
          textAlign: TextAlign.right,
          decoration: MainTextFieldInputDecoration(label),
          validator: _validatePassword,
          autovalidateMode: AutovalidateMode.onUserInteraction,
          obscureText: true,
        ),
      ),
    );
  }
}

String? _validateEmail(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter an email address.';
  }
  final RegExp emailRegex = RegExp(
    r'^[a-zA-Z0-9._%+-]+@[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}$',
  );
  if (!emailRegex.hasMatch(value)) {
    return 'Please enter a valid email address.';
  }
  return null;
}


String? _validatePassword(String? value) {
  if (value == null || value.isEmpty) {
    return 'Please enter a password.';
  }
  if (value.length < 7) {
    return 'Password should contain min 6 characters';
  }
  return null;
}




