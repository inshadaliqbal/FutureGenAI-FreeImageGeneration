import 'package:flutter/material.dart';
import 'package:futuregenai/widgets/reusable_widgets.dart';
import 'package:provider/provider.dart';
import '../helpers/provider_engine.dart';
import '../buttons/buttons.dart';
import '../style/constants.dart';
import 'login_page.dart';
import 'prompt_page.dart';
import '../widgets/extracted_widgets.dart';

class RegistrationPage extends StatefulWidget {
  static const String registrationScreen = 'registration_screen';

  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<RegistrationPage> createState() => _RegistrationPageState();
}

class _RegistrationPageState extends State<RegistrationPage> {
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
                        'Welcome!',
                        style: kMainTextstyleWelcomePage,
                      ),
                    ),
                    Text(
                      'Please register',
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
                    SizedBox(
                      height: 10,
                    ),
                    MainButton(
                      buttonText: 'REGISTER ',
                      buttonFunction: () async {
                        List returnedData = await Provider.of<MainEngine>(
                          context,
                          listen: false,
                        ).signUP(email, password);
                        if (returnedData[1]) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) {
                                return PromptPage(imagePath: returnedData[0]);
                              },
                            ),
                          );
                        } else {}
                      },
                    ),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "Already have an account? ",
                      style: TextStyle(color: Colors.white),
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, LoginPage.loginPage);
                      },
                      child: Text(
                        'Sign IN',
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
