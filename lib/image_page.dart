import 'dart:async';

import 'package:flutter/material.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'dart:io' show Platform;
import 'package:flutter/foundation.dart';

class ImagePage extends StatelessWidget {
  static const imagePage = 'image_page';
  String? prompt;

  ImagePage({super.key,required this.prompt});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        child: SizedBox(),
        // child: FutureBuilder<Uint8List>(
        //   // Call the generate() function to get the image data
        //   future:Provider.of<MainEngine>(context).imageCreation(prompt),
        //   builder: (context, snapshot) {
        //     if (snapshot.connectionState == ConnectionState.waiting) {
        //       // While waiting for the image data, display a loading indicator
        //       return const CircularProgressIndicator();
        //     } else if (snapshot.hasError) {
        //       // If an error occurred while getting the image data, display an error
        //       return Text('Error: ${snapshot.error}');
        //     } else if (snapshot.hasData) {
        //       // If the image data is available, display the image using Image.memory()
        //       return Image.memory(snapshot.data!);
        //     } else {
        //       // If no data is available, display a placeholder or an empty container
        //       return Container();
        //     }
        //   },
        // ),
      ),
    );
  }
}
