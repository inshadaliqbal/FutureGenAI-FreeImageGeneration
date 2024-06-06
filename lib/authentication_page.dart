import 'package:flutter/material.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:futuregenai/buttons.dart';
import 'package:futuregenai/constants.dart';
import 'package:futuregenai/extracted_widgets.dart';
import 'package:futuregenai/login_page.dart';
import 'package:futuregenai/registration_page.dart';
import 'package:futuregenai/provider_engine.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthenticationPage extends StatelessWidget {
  static const authenticationPage = 'authentication_page';

  const AuthenticationPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlurryHUD(
        childWidget: Stack(
          children: [
            BackgroundImage(imagePath: 'images/bg2.jpeg'),
            GradientContainer(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Text(
                    'Welcome...Show your creativity',
                    style: kMainTextstyleWelcomePage,
                  ),
                  SizedBox(height: 30),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MainButton(
                        buttonFunction: () {
                          Navigator.pushNamed(context, LoginPage.loginPage);
                        },
                        buttonText: "Sign IN",
                      ),
                      SizedBox(height: 20),
                      MainButton(
                        buttonFunction: () {
                          Navigator.pushNamed(
                              context, RegistrationPage.registrationScreen);
                        },
                        buttonText: 'Sign UP',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
