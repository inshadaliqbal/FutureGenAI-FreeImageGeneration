import 'dart:typed_data';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:futuregenai/pages/authentication_page.dart';
import 'package:futuregenai/buttons/buttons.dart';
import 'package:futuregenai/style/constants.dart';
import 'package:futuregenai/widgets/extracted_widgets.dart';
import 'package:futuregenai/helpers/provider_engine.dart';
import 'package:futuregenai/style/style.dart';
import 'package:provider/provider.dart';

class MainTextField extends StatelessWidget {
  final Function changeFunction;
  final String? label;

  MainTextField({Key? key, required this.label, required this.changeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => changeFunction(value),
          textAlign: TextAlign.left,
          decoration: MainTextFieldInputDecoration(label),
          validator: _validateEmail,
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}

class MainTextFieldAPI extends StatelessWidget {
  final Function changeFunction;
  final String? label;

  MainTextFieldAPI({Key? key, required this.label, required this.changeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        child: TextFormField(
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) => changeFunction(value),
          textAlign: TextAlign.right,
          decoration: MainTextFieldInputDecoration(label),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}

class PromptTextField extends StatelessWidget {
  final Function changeFunction;
  final String? label;

  PromptTextField({Key? key, required this.label, required this.changeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        child: TextFormField(
          maxLines: 7,
          keyboardType: TextInputType.multiline,
          onChanged: (value) => changeFunction(value),
          textAlign: TextAlign.left,
          decoration: PromptTextFieldInputDecoration(label),
          autovalidateMode: AutovalidateMode.onUserInteraction,
        ),
      ),
    );
  }
}

class MainTextFieldPassword extends StatelessWidget {
  final Function changeFunction;
  final String? label;

  MainTextFieldPassword({Key? key, required this.label, required this.changeFunction})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) => changeFunction(value),
          textAlign: TextAlign.left,
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
    return 'Password should contain at least 6 characters';
  }
  return null;
}

class ProgressIndicatorContainer extends StatelessWidget {
  const ProgressIndicatorContainer({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(
        maxHeight: 200,
        maxWidth: 300,
        minHeight: 100,
        minWidth: 100,
      ),
      decoration: BoxDecoration(
        color: Colors.white.withOpacity(0.5),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Text(
            'Loading Please Wait',
            style: TextStyle(fontSize: 20),
          ),
          SpinKitFadingCircle(
            color: Colors.white,
            size: 50.0,
          ),
        ],
      ),
    );
  }
}

class ImageCard extends StatelessWidget {
  final Uint8List? imageBytes;

  ImageCard({Key? key, required this.imageBytes}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: MemoryImage(imageBytes!),
          fit: BoxFit.fitHeight,
        ),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {
  final String imagePath;

  BackgroundImage({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
          image: AssetImage(imagePath),
          fit: BoxFit.cover,
        ),
      ),
    );
  }
}

class MainImageCard extends StatelessWidget {
  final ImageProvider imagePath;

  MainImageCard({Key? key, required this.imagePath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(minWidth: 200, minHeight: 100, maxHeight: 200),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(image: imagePath, fit: BoxFit.cover),
      ),
    );
  }
}


class BlurryHUD extends StatelessWidget {
  final Widget childWidget;

  BlurryHUD({Key? key, required this.childWidget}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlurryModalProgressHUD(
      inAsyncCall: Provider.of<MainEngine>(context).getLoadingBool(),
      blurEffectIntensity: 4,
      progressIndicator: ProgressIndicatorContainer(),
      dismissible: false,
      opacity: 0.4,
      color: Colors.black,
      child: childWidget,
    );
  }
}
