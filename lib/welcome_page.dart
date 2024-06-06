import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:futuregenai/reusable_widgets.dart';
import 'package:provider/provider.dart';
import 'provider_engine.dart';
import 'extracted_widgets.dart';

class WelcomePage extends StatefulWidget {
  static const String welcomePage = 'welcome_page';

  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  Uint8List? bgImageBytes;

  @override
  void initState() {
    super.initState();
    Provider.of<MainEngine>(context, listen: false).intializeApp();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlurryHUD(
        childWidget: WelcomePageFutureBuilder(),
      ),
    );
  }
}

