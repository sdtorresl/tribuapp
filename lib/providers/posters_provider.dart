import 'dart:convert';
import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';

import '../models/video_poster_model.dart';
import 'package:http/http.dart' as http;

class PosterProvider {
  final String _host = GlobalConfiguration().getValue("api_url");

  Future<List<VideoPosterModel>> getPosters() async {
    final String url = "$_host/json-video-poster";

    try {
      var response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.decode(response.body);
        return (jsonResponse[0]["posters"] as List<dynamic>)
            .map((e) => VideoPosterModel.fromMap(e))
            .toList();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log("Error getting posters...", error: e);
    }

    return [];
  }

  Future<bool> votePoster(posterId) async {
    final String url = "$_host/webform_rest/submit";

    try {
      String username = 'eweb';
      String password = 'E02i4BMX';
      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      String body = json.encode({
        'webform_id': "encuesta_video_app",
        '_cual_video_te_gusto_mas_': posterId.toString()
      });

      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: <String, String>{
          'authorization': basicAuth,
          'content-type': 'application/json'
        },
      );

      if (response.statusCode == 200) {
        return true;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log("Error voting poster...", error: e);
    }

    return false;
  }
}
