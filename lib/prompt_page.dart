import 'package:flutter/material.dart';
import 'package:futuregenai/buttons.dart';
import 'package:futuregenai/image_page.dart';
import 'extracted_widgets.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class PromptPage extends StatelessWidget {
  static const promptPage = 'prompt_page';
  PromptPage({super.key});

  @override
  Widget build(BuildContext context) {
    String? inputPrompt;
    return Scaffold(
      body: Container(
        child: Column(
          children: [
            MainTextFieldAPI(
                label: "prompt",
                changeFunction: (value) {
                  inputPrompt = value;
                }),
            MainButton(
                buttonText: 'Proceed',
                buttonOnPress: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) {
                      return ImagePage(prompt: inputPrompt);
                    }),
                  );
                })
          ],
        ),
      ),
    );
  }
}
