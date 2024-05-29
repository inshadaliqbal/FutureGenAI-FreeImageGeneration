import 'package:flutter/material.dart';
import 'package:futuregenai/prompt_page.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'extracted_widgets.dart';
import 'buttons.dart';

class ApiPage extends StatelessWidget {
  static const apiPage = 'api_page';
  String? apiKey;
  ApiPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          MainTextFieldAPI(
            label: 'API KEY',
            changeFunction: (value) {
              apiKey = value;
            },
          ),
          MainButton(
              buttonText: 'Proceed',
              buttonOnPress: () {
                Navigator.pushNamed(context, PromptPage.promptPage);
              }),
        ],
      ),
    );
  }
}
