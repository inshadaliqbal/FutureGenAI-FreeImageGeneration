import 'package:flutter/material.dart';
import 'package:futuregenai/pages/registration_page.dart';
import 'package:futuregenai/pages/prompt_page.dart';
import 'package:futuregenai/buttons/buttons.dart';
import 'package:futuregenai/widgets/extracted_widgets.dart';
import 'package:futuregenai/helpers/provider_engine.dart';
import 'package:futuregenai/widgets/reusable_widgets.dart';
import 'package:provider/provider.dart';
import 'package:futuregenai/style/constants.dart';

class LoginPage extends StatelessWidget {
  static const loginPage = 'login_page';

  LoginPage({Key? key});

  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.black,
      body: SafeArea(
        child: BlurryHUD(
          childWidget: Padding(
            padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 150.0, top: 50),
                      child: Text(
                        'Welcome Back! ',
                        style: kMainTextstyleWelcomePage,
                      ),
                    ),
                    Text(
                      'Please login to your account ',
                      style: TextStyle(color: Colors.white),
                    ),
                    MainTextFieldSign(
                      label: 'EMAIL ',
                      changeFunction: (value) {
                        email = value;
                      },
                    ),
                    MainTextFieldPassword(
                      label: 'PASSWORD ',
                      changeFunction: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(height: 10),
                    MainButton(
                      buttonText: 'Sign IN',
                      buttonFunction: () async {
                        List returnedData = await Provider.of<MainEngine>(
                          context,
                          listen: false,
                        ).signIN(email, password);
                        if (returnedData[1]) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PromptPage(imagePath: returnedData[0]);
                              },
                            ),
                          );
                        } else {
                          // Handle failure case
                        }
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Don't have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(
                          context,
                          RegistrationPage.registrationScreen,
                        );
                      },
                      child: Text(
                        'Sign UP',
                        style: TextStyle(color: Colors.white),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
