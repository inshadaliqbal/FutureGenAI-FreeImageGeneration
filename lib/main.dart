import 'package:flutter/material.dart';
import 'package:futuregenai/pages/authentication_page.dart';
import 'package:futuregenai/pages/history_page.dart';
import 'package:futuregenai/pages/image_page.dart';
import 'package:futuregenai/pages/login_page.dart';
import 'package:futuregenai/helpers/provider_engine.dart';
import 'package:futuregenai/pages/registration_page.dart';
import 'package:futuregenai/pages/welcome_page.dart';
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
