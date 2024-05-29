import 'package:flutter/material.dart';
import 'package:futuregenai/api_page.dart';
import 'buttons.dart';
import 'extracted_widgets.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
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
      body: BlurryModalProgressHUD(
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
        ),
        child: Column(
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
              buttonColor: Colors.blueAccent.shade200,
              buttonText: 'Sign IN',
              buttonOnPress: () async {
                // Performing user registration and navigating to task screen if successful
                if (await Provider.of<MainEngine>(context, listen: false)
                    .signIN(email, password)) {
                  Navigator.pushNamed(context, ApiPage.apiPage);
                } else {}
              },
            ),
          ],
        ),
      ),
    );
  }
}
