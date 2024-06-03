import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'style.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';



class MainTextField extends StatelessWidget {
  Function changeFunction;
  String? label;
  final _formKey = GlobalKey<FormState>();

  MainTextField({super.key, required this.label, required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Form(
        key: _formKey,
        child: TextFormField(

          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.emailAddress,
          onChanged: (value) {
            changeFunction(value);
          },
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
  Function changeFunction;
  String? label;
  final _formKey = GlobalKey<FormState>();

  MainTextFieldAPI({super.key, required this.label, required this.changeFunction});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
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
      child: Form(
        key: _formKey,
        child: TextFormField(
          style: TextStyle(color: Colors.white),
          keyboardType: TextInputType.visiblePassword,
          onChanged: (value) {
            changeFunction(value);
          },
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
    return 'Password should contain min 6 characters';
  }
  return null;
}


class ProgressIndicatorContainer extends StatelessWidget {
  const ProgressIndicatorContainer({
    super.key,
  });

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

class GradientContainer extends StatelessWidget {
  const GradientContainer({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [Colors.transparent, Colors.black], // Violet to pink gradient
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
        ),
      ),
    );
  }
}

class BlurryHUD extends StatelessWidget {
  Widget childWidget;

  BlurryHUD({super.key, required this.childWidget});

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



class ImageCard extends StatelessWidget {
  Uint8List? imageBytes;
  ImageCard({super.key, @required this.imageBytes});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: MemoryImage(imageBytes!), fit: BoxFit.fitHeight),
      ),
    );
  }
}

class BackgroundImage extends StatelessWidget {

  String imagePath;
  BackgroundImage({
    super.key,required this.imagePath
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(10),
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage(
              imagePath,
            ),
            fit: BoxFit.cover),
      ),
    );
  }
}


class MainImageCard extends StatelessWidget {
  ImageProvider imagePath;

  MainImageCard({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        image: DecorationImage(image: imagePath, fit: BoxFit.cover),
      ),
    );
  }
}
