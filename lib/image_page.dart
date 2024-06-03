import 'dart:typed_data';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:futuregenai/buttons.dart';
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
      body: Container(
        child: FutureBuilder<Uint8List>(
          future: Provider.of<MainEngine>(context).imageCreation(prompt),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const CircularProgressIndicator();
            } else if (snapshot.hasError) {
              return Text('Error: ${snapshot.error}');
            } else if (snapshot.hasData) {
              return Column(
                children: [
                  Expanded(
                    child: MainImageCard(
                      imagePath: MemoryImage(snapshot.data!),
                    ),
                  ),
                  MainButton(
                      buttonText: 'Download',
                      buttonFunction: () {
                        saveImage(snapshot.data!);
                      }),
                  MainButton(
                    buttonText: 'History',
                    buttonFunction: () {
                      Navigator.pushNamed(context, HistoryPage.history_page);
                    },
                  ),
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

