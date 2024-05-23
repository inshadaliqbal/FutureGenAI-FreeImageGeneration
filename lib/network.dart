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
    'X-Key': 'Key 5441B1403EA157ED10CCA4FFC3894247',
    'X-Secret': 'Secret 9286322093165E4AF68D2CE6BAC80623',
  };

  Text2ImageAPI(this.url, this.apiKey, this.secretKey);

  Future<String> getModel() async {
    final response = await http.get(Uri.parse('${url}key/api/v1/models'),
        headers: authHeaders);

    final responseBody = response.body;
    print(jsonDecode(responseBody)[0]['id']);
    return jsonDecode(responseBody)[0]['id'].toString();
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
    final data = {
      'model_id': 'None,$model',
      'params': 'None,${jsonEncode(params)},application/json'
    };

    final body = jsonEncode({
      'model_id': model,
      'params': params,
      'Content-Type': 'application/json'
    });

    final headers = {
      'Content-Type': 'application/json',
      ...authHeaders,
    };

    try {
      final response = await http.post(
        Uri.parse('${url}key/api/v1/text2image/run'),
        headers: headers,
        body: body,
      );

      // Print the status code and response body for debugging
      print('Response Status Code: ${response.statusCode}');
      print('Response Body: ${response.body}');

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        if (data.containsKey('uuid')) {
          return data['uuid'];
        } else {
          throw Exception('UUID not found in response');
        }
      } else if (response.statusCode == 401) {
        throw Exception('Unauthorized: Check your authentication token and headers.');
      } else {
        throw Exception('Failed to generate image: ${response.statusCode} ${response.body}');
      }
    } catch (e) {
      print('Error: $e');
      rethrow;
    }
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
