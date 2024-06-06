import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:futuregenai/pages/authentication_page.dart';
import 'package:futuregenai/buttons/buttons.dart';
import 'package:futuregenai/style/constants.dart';
import 'package:futuregenai/helpers/provider_engine.dart';
import 'package:futuregenai/widgets/reusable_widgets.dart';
import 'package:provider/provider.dart';
import '../style/style.dart';


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