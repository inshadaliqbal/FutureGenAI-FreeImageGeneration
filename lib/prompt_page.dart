import 'package:flutter/material.dart';
import 'package:futuregenai/buttons.dart';
import 'package:futuregenai/constants.dart';
import 'package:futuregenai/image_page.dart';
import 'package:futuregenai/style.dart';
import 'extracted_widgets.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';

class PromptPage extends StatelessWidget {
  static const promptPage = 'prompt_page';
  var imagePath;
  PromptPage({super.key, required this.imagePath});

  @override
  Widget build(BuildContext context) {
    String? inputPrompt;
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        decoration: BoxDecoration(
          image:
              DecorationImage(image: MemoryImage(imagePath), fit: BoxFit.cover),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Container(
              decoration: BoxDecoration(
                color: Colors.white.withOpacity(0.7),
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(15),
                  topRight: Radius.circular(15),
                ),
              ),
              height: 400,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Enter Prompt',
                          style: kMainTextstyleWelcomePage.copyWith(color: Colors.black,fontSize: 20),
                        ),
                        PromptTextField(
                            label: "Type a prompt",
                            changeFunction: (value) {
                              inputPrompt = value;
                            }),

                      ],
                    ),
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
            ),
          ],
        ),
      ),
    );
  }
}
