import 'dart:convert';
import 'dart:io';
import 'dart:async';
import 'package:futuregenai/secret_const.dart';
import 'package:http/http.dart' as http;

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
//   Future<List<String>> checkGeneration(String requestId, {int attempts = 10, int delay = 10}) async {
//     while (attempts > 0) {
//       final response = await HttpClient()
//           .getUrl(Uri.parse('$url/key/api/v1/text2image/status/$requestId'))
//           .then((HttpClientRequest request) {
//         request.headers.add('X-Key', 'Key $apiKey');
//         request.headers.add('X-Secret', 'Secret $secretKey');
//         return request.close();
//       });
//
//       final responseBody = await response.transform(utf8.decoder).join();
//       final data = json.decode(responseBody);
//
//       if (data['status'] == 'DONE') {
//         return List<String>.from(data['images']);
//       }
//
//       attempts--;
//       await Future.delayed(Duration(seconds: delay));
//     }
//
//     throw Exception('Image generation failed or timed out.');
//   }
// }
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
