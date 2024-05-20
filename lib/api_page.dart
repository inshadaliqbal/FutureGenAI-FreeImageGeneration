import 'package:flutter/material.dart';
import 'provider_engine.dart';
import 'package:provider/provider.dart';
import 'extracted_widgets.dart';
import 'buttons.dart';

class API_Page extends StatelessWidget {
  String? apiKey;
  API_Page({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        MainTextFieldAPI(
          label: 'API KEY',
          changeFunction: (value) {
            apiKey = value;
          },
        ),
        MainButton(buttonText: 'Proceed', buttonOnPress: () {}),
      ],
    );
  }
}
