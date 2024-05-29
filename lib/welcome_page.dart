import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:futuregenai/authentication_page.dart';
import 'package:futuregenai/main.dart';
import 'package:futuregenai/provider_engine.dart';
import 'package:provider/provider.dart';
import 'package:blurry_modal_progress_hud/blurry_modal_progress_hud.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

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
        progressIndicator: Container(
          constraints: BoxConstraints(
            maxHeight: 200,
            maxWidth: 300,
            minHeight: 100,
            minWidth: 100,
          ),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.5),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            children: [
              Text(
                'Loading Please Wait',
                style: TextStyle(fontSize: 20),
              ),
              SpinKitFadingCircle(
                color: Colors.white,
                size: 50.0,
              ),
            ],
          ),
        ),
        dismissible: false,
        opacity: 0.4,
        color: Colors.black,
        child: Container(
          child: FutureBuilder<Uint8List?>(
            // Call the generate() function to get the image data
            future:Provider.of<MainEngine>(context).imageCreationForBackground(),
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
                  Container(
                    padding: EdgeInsets.all(10),
                    decoration: BoxDecoration(
                      image: DecorationImage(
                          image: MemoryImage(snapshot.data!),
                          fit: BoxFit.fitHeight),
                    ),
                  ),
                  Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [
                          Colors.transparent,
                          Colors.black
                        ], // Violet to pink gradient
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                    ),
                  ),
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
                        Container(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              colors: [
                                Color(0xFF8A2BE2),
                                Color(0xFFFF69B4)
                              ], // Violet to pink gradient
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                            ),
                            borderRadius: BorderRadius.circular(30),
                          ),
                          child: TextButton(
                            style: TextButton.styleFrom(
                              padding:
                              EdgeInsets.symmetric(horizontal: 15, vertical: 5),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                              backgroundColor: Colors
                                  .transparent, // Ensure background is transparent to show gradient
                            ),
                            onPressed: () {
                              Navigator.pushNamed(
                                  context, AuthenticationPage.authenticationPage);
                            },
                            child: Text(
                              'Get Started',
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 25,
                                fontWeight: FontWeight.w400,
                                letterSpacing: 2,
                              ),
                            ),
                          ),
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
          )


        ),
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
