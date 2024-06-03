import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:futuregenai/registration_page.dart';
import 'prompt_page.dart';
import 'buttons.dart';
import 'extracted_widgets.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'constants.dart';

class LoginPage extends StatelessWidget {
  static const loginPage = 'login_page';
  LoginPage({super.key});
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

            padding: const EdgeInsets.symmetric(vertical: 30.0,horizontal: 10.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 150.0,top: 50),
                      child: Text(
                        'Welcome Back!',
                        style: kMainTextstyleWelcomePage,
                      ),
                    ),
                    Text(
                      'Please login to your account',
                      style: TextStyle(color: Colors.white),
                    ),
                    MainTextField(
                      label: 'EMAIL',
                      changeFunction: (value) {
                        email = value;
                      },
                    ),
                    MainTextFieldPassword(
                      label: 'PASSWORD',
                      changeFunction: (value) {
                        password = value;
                      },
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    MainButton(
                      buttonText: 'Sign IN',
                      buttonFunction: () async {
                        if (await Provider.of<MainEngine>(context, listen: false)
                            .signIN(email, password)) {
                          Navigator.pushNamed(context, PromptPage.promptPage);
                        } else {}
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
                            context, RegistrationPage.registrationScreen);
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
