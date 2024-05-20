import 'package:flutter/material.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:futuregenai/login_page.dart';
import 'package:futuregenai/registration_page.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

class AuthenticationPage extends StatelessWidget {
  static const authenticationPage = 'authentication_page';
  const AuthenticationPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: BlurryModalProgressHUD(
          inAsyncCall: Provider.of<MainEngine>(context).getLoadingBool(),
          blurEffectIntensity: 4,
          progressIndicator: Container(
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
          ),
          dismissible: false,
          opacity: 0.4,
          color: Colors.black,
          child: Container(
            child: Stack(children: [
              Container(
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage(
                        'images/bg2.jpeg',
                      ),
                      fit: BoxFit.cover),
                ),
              ),
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [
                      Colors.transparent,
                      Colors.black
                    ], // Violet to pink gradient
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(10.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Text(
                      'Welcome...Show your creativity',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 40,
                        fontWeight: FontWeight.w400,
                        letterSpacing: 2,
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Container(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors
                                  .transparent, // Ensure background is transparent to show gradient
                            ),
                            onPressed: () {
                              Navigator.pushNamed(context, LoginPage.loginPage);
                            },
                            child: Text(
                              'Sign IN',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Container(
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
                              padding: EdgeInsets.symmetric(
                                  horizontal: 15, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors
                                  .transparent, // Ensure background is transparent to show gradient
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, RegistrationPage.registrationScreen);
                            },
                            child: Text(
                              'Sign Up',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ]),
          ),
        ),
      ),
    );
  }
}
