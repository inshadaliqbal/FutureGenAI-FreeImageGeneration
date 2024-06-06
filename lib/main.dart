import 'package:flutter/material.dart';
import 'package:futuregenai/authentication_page.dart';
import 'package:futuregenai/history_page.dart';
import 'package:futuregenai/image_page.dart';
import 'package:futuregenai/login_page.dart';
import 'package:futuregenai/provider_engine.dart';
import 'package:futuregenai/registration_page.dart';
import 'package:futuregenai/welcome_page.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const FutureGenAI());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

class FutureGenAI extends StatelessWidget {
  const FutureGenAI({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainEngine(),
      builder: (context, _) {
        return MaterialApp(
          navigatorKey: navigatorKey,
          initialRoute: WelcomePage.welcomePage,
          routes: {
            WelcomePage.welcomePage: (context) => const WelcomePage(),
            AuthenticationPage.authenticationPage: (context) => const AuthenticationPage(),
            RegistrationPage.registrationScreen: (context) => const RegistrationPage(),
            LoginPage.loginPage: (context) => LoginPage(),
            ImagePage.imagePage: (context) => ImagePage(prompt: ''),
            HistoryPage.history_page: (context) => const HistoryPage(),
          },
        );
      },
    );
  }
}
