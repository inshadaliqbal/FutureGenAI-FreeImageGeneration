import 'package:flutter/material.dart';
import 'package:futuregenai/buttons/buttons.dart';
import 'package:futuregenai/style/constants.dart';
import 'package:futuregenai/pages/image_page.dart';
import 'package:futuregenai/widgets/reusable_widgets.dart';
import 'package:futuregenai/style/style.dart';
import '../widgets/extracted_widgets.dart';
import '../helpers/provider_engine.dart';
import 'package:provider/provider.dart';

class PromptPage extends StatelessWidget {
  static const promptPage = 'prompt_page';
  final imagePath;
  PromptPage({Key? key, required this.imagePath}) : super(key: key);

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
              decoration: kPromptPageContainerDecoration,
              height: 400,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        Text(
                          'Enter Prompt',
                          style: kMainTextstyleWelcomePage.copyWith(
                              color: Colors.black, fontSize: 20),
                        ),
                        PromptTextField(
                          label: "Type a prompt ",
                          changeFunction: (value) {
                            inputPrompt = value;
                          },
                        ),
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
