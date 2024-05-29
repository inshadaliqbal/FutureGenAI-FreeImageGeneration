import 'dart:convert';
import 'dart:async';
import 'package:futuregenai/secret_const.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';
import 'package:together_ai_sdk/together_ai_sdk.dart';


Future<Uint8List> getData(String prompt) async {
  final togetherAI = TogetherAISdk(
    togetheraiAPI,
  );
  final imageResponse = await togetherAI.imageGeneration(prompt, imageModel: ImageModel.realisticVision3_0);
  return base64.decode(imageResponse!.data[0].b64Json);
}
