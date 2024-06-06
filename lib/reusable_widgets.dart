import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:futuregenai/authentication_page.dart';
import 'package:futuregenai/buttons.dart';
import 'package:futuregenai/constants.dart';
import 'package:futuregenai/extracted_widgets.dart';
import 'package:futuregenai/provider_engine.dart';
import 'package:provider/provider.dart';


class WelcomePageFutureBuilder extends StatelessWidget {
  const WelcomePageFutureBuilder({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<Uint8List?>(
      future: Provider.of<MainEngine>(context).imageCreationForBackground(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          return Stack(
            children: [
              ImageCard(imageBytes: snapshot.data),
              GradientContainer(),
              Padding(
                padding: const EdgeInsets.symmetric(vertical: 30.0, horizontal: 20.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    const Text(
                      'Imagination to Image',
                      style: kMainTextstyleWelcomePage,
                    ),
                    SizedBox(height: 30),
                    MainButton(
                      buttonFunction: () {
                        Navigator.pushNamed(context, AuthenticationPage.authenticationPage);
                      },
                      buttonText: "Get Started",
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return Container();
        }
      },
    );
  }
}
