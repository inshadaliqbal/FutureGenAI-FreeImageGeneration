import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:futuregenai/buttons.dart';
import 'package:futuregenai/constants.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'package:flutter/foundation.dart';
import 'history_page.dart';
import 'functions.dart';
import 'extracted_widgets.dart';

class ImagePage extends StatelessWidget {
  static const imagePage = 'image_page';
  String? prompt;

  ImagePage({super.key, required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: Colors.transparent,
        title: Center(
          child: Text(
            'Image',style: TextStyle(fontFamily: 'highland',color: Colors.white),
          ),
        ),
      ),
      backgroundColor: Colors.black,
      body: FutureBuilder<Uint8List>(
        future: Provider.of<MainEngine>(context).imageCreation(prompt),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Container(
                color: Colors.black,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Please wait...Image being cooked',
                      style: kMainTextstyleWelcomePage.copyWith(fontSize: 15),
                    ),
                    CircularProgressIndicator(),
                  ],
                ),
              ),
            );
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else if (snapshot.hasData) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 20, horizontal: 10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Expanded(
                    child: MainImageCard(
                      imagePath: MemoryImage(snapshot.data!),
                    ),
                  ),
                  SizedBox(
                    height: 30,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      MainButton(
                          buttonText: 'Download',
                          buttonFunction: () {
                            saveImage(snapshot.data!);
                          }),
                      SizedBox(
                        height: 10,
                      ),
                      MainButton(
                        buttonText: 'History',
                        buttonFunction: () {
                          Navigator.pushNamed(
                              context, HistoryPage.history_page);
                        },
                      ),
                    ],
                  )
                ],
              ),
            );
          } else {
            // If no data is available, display a placeholder or an empty container
            return Container();
          }
        },
      ),
    );
  }
}
