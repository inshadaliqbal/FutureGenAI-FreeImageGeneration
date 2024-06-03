import 'package:flutter/material.dart';
import 'package:futuregenai/buttons.dart';
import 'package:futuregenai/image_page.dart';
import 'extracted_widgets.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';

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
              buttonFunction: () {
                Provider.of<MainEngine>(context, listen: false)
                    .imageCreation('prompt');
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) {
                      return ImagePage(prompt: inputPrompt);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
