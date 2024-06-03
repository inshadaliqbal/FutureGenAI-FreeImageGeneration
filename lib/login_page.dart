import 'package:flutter/material.dart';
import 'prompt_page.dart';
import 'buttons.dart';
import 'extracted_widgets.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';

class LoginPage extends StatelessWidget {
  static const loginPage = 'login_page';
  LoginPage({super.key});
  String? email;
  String? password;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFFFF2E1),
      body: BlurryHUD(
        childWidget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Title and logo

            Text('Welcome Back...'),
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
      ),
    );
  }
}
