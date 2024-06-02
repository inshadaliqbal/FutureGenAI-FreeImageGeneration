import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futuregenai/authentication_page.dart';
import 'package:futuregenai/provider_engine.dart';
import 'package:provider/provider.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'extracted_widgets.dart';
import 'buttons.dart';
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
      body: BlurryModalProgressHUD(
        inAsyncCall: Provider.of<MainEngine>(context).getLoadingBool(),
        blurEffectIntensity: 4,
        progressIndicator: ProgressIndicatorContainer(),
        dismissible: false,
        opacity: 0.4,
        color: Colors.black,
        child: Container(
            child: FutureBuilder<Uint8List?>(
          // Call the generate() function to get the image data
          future: Provider.of<MainEngine>(context).imageCreationForBackground(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the image data, display a loading indicator
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              // If an error occurred while getting the image data, display an error
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // If the image data is available, display the image using Image.memory()
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
                      Text(
                        'Generate Art From Text',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 40,
                          fontWeight: FontWeight.w400,
                          letterSpacing: 2,
                        ),
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
              // If no data is available, display a placeholder or an empty container
              return Container();
            }
          },
        )),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty('bgImageBytes', bgImageBytes));
    properties.add(DiagnosticsProperty('bgImageBytes', bgImageBytes));
  }
}

