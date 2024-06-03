import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futuregenai/authentication_page.dart';
import 'package:futuregenai/provider_engine.dart';
import 'package:provider/provider.dart';
import 'extracted_widgets.dart';
import 'buttons.dart';
import 'constants.dart';

class WelcomePage extends StatefulWidget {
  static const welcomePage = 'welcome_page';
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Uint8List? bgImageBytes;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    Provider.of<MainEngine>(context, listen: false).intializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlurryHUD(
        childWidget: Container(
            child: FutureBuilder<Uint8List?>(
          future: Provider.of<MainEngine>(context).imageCreationForBackground(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Stack(children: [
                ImageCard(
                  imageBytes: snapshot.data,
                ),
                GradientContainer(),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      const Text(
                        'Generate Art From Text',
                        style: kMainTextstyleWelcomePage,
                      ),
                      MainButton(
                        buttonFunction: () {
                          Navigator.pushNamed(
                              context, AuthenticationPage.authenticationPage);
                        },
                        buttonText: "Get Started",
                      ),
                    ],
                  ),
                ),
              ]);
            } else {
              return Container();
            }
          },
        )),
      ),
    );
  }

  // @override
  // void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  //   super.debugFillProperties(properties);
  //   properties.add(DiagnosticsProperty('bgImageBytes', bgImageBytes));
  //   properties.add(DiagnosticsProperty('bgImageBytes', bgImageBytes));
  // }
}
