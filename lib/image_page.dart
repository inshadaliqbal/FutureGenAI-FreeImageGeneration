import 'dart:async';
import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:futuregenai/buttons.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'history_page.dart';
import 'functions.dart';

class ImagePage extends StatelessWidget {
  static const imagePage = 'image_page';
  String? prompt;

  ImagePage({super.key, required this.prompt});


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        // child: SizedBox(),
        child: FutureBuilder<Uint8List>(
          // Call the generate() function to get the image data
          future: Provider.of<MainEngine>(context).imageCreation(prompt),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              // While waiting for the image data, display a loading indicator
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              // If an error occurred while getting the image data, display an error
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              // If the image data is available, display the image using Image.memory()
              return Column(
                children: [
                  Expanded(
                    child: Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(40),
                        image: DecorationImage(
                            image: MemoryImage(snapshot.data!),
                            fit: BoxFit.cover),
                      ),
                    ),
                  ),
                  MainButton(
                      buttonText: 'Download',
                      buttonOnPress: () {
                        saveImage(snapshot.data!);
                      }),
                  MainButton(buttonText: 'History', buttonOnPress: () {
                    Navigator.pushNamed(context, HistoryPage.history_page);
                  })
                ],
              );
            } else {
              // If no data is available, display a placeholder or an empty container
              return Container();
            }
          },
        ),
      ),
    );
  }
}
