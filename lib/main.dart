import 'package:flutter/material.dart';
import 'package:futuregenai/api_page.dart';
import 'package:futuregenai/authentication_page.dart';
import 'package:futuregenai/history_page.dart';
import 'package:futuregenai/image_page.dart';
import 'package:futuregenai/login_page.dart';
import 'package:futuregenai/prompt_page.dart';
import 'package:futuregenai/provider_engine.dart';
import 'package:futuregenai/registration_page.dart';
import 'package:futuregenai/welcome_page.dart';
import 'package:provider/provider.dart';
import 'package:permission_handler/permission_handler.dart';

void main() {
  runApp(FutureGenAI());
}

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
class FutureGenAI extends StatelessWidget {

  FutureGenAI({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => MainEngine(),
      builder: (context,MainEngine){
        return MaterialApp(
          navigatorKey: navigatorKey,
          initialRoute: WelcomePage.welcomePage,
          routes: {
            WelcomePage.welcomePage : (context) => const WelcomePage(),
            AuthenticationPage.authenticationPage:(context)=> const AuthenticationPage(),
            RegistrationPage.registrationScreen : (context) => const RegistrationPage(),
            LoginPage.loginPage: (context) => LoginPage(),
            ApiPage.apiPage:(context) => ApiPage(),
            PromptPage.promptPage:(context) => PromptPage(),
            ImagePage.imagePage:(context) => ImagePage(prompt: '',),
            HistoryPage.history_page:(context)=> HistoryPage(),
          },
        );
      },
    );
  }
}
