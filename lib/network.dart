import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:futuregenai/secret_const.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/foundation.dart';

class Text2ImageAPI {
  final String url;
  final String apiKey;
  final String secretKey;
  Map<String, String> authHeaders = {
    'X-Key': 'Key $aiAPI',
    'X-Secret': 'Secret $aiSecretKey',
  };

  Text2ImageAPI(this.url, this.apiKey, this.secretKey);

  Future<String> getModel() async {
    final response = await http.get(Uri.parse('${url}key/api/v1/models'),
        headers: authHeaders);

    final responseBody = response.body;
    return jsonDecode(responseBody)[0]['id'];
  }

  Future<String> generate(String prompt, String model,
      {int images = 1, int width = 1024, int height = 1024}) async {
    Map<String, dynamic> params = {
      "type": "GENERATE",
      "style": "moreDetails",
      "numImages": images,
      "width": width,
      "height": height,
      "generateParams": {"query": prompt}
    };
    final data = '''{
      "model_id": None,$model,
      "params": None,${jsonEncode(params)},"application/json"
    }''';

    http.Client client = http.Client();
    http.Response response = await client.post(
        Uri.parse('${url}key/api/v1/text2image/run'),
        headers: authHeaders,
        body: data);
    print('Strilll');
    var responseBody = response.body;
    print(responseBody);
    print(jsonDecode(responseBody)["uuid"]);
    return jsonDecode(responseBody)['uuid'];
    // Create headers
  }

//
  Future<Uint8List> checkGeneration(String requestId,
      {int attempts = 10, int delay = 10}) async {
    final response = await http.get(
      Uri.parse('${url}key/api/v1/text2image/status/$requestId'),
      headers: authHeaders,
    );

    final responseBody = await response.body;
    final data = json.decode(responseBody);
    print(data['status']);
    Uint8List bytes = await base64.decode(data['images'][0]);
    return bytes;
  }
//
// class MultipartRequest {
//   final Map<String, String> fields = {};
//
//   void writeTo(HttpClientRequest request) {
//     fields.forEach((key, value) {
//       request.write('--boundary\r\n');
//       request.write('Content-Disposition: form-data; name="$key"\r\n\r\n');
//       request.write('$value\r\n');
//     });
//     request.write('--boundary--\r\n');
//   }
}
