import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import '../models/event_model.dart';

class EventProvider {
  final String _url =
      "${GlobalConfiguration().getValue("api_url")}/json-evento-seedem";

  Future<EventModel?> getEvent() async {
    try {
      var response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        EventModel event = EventModel.fromMap(jsonResponse[0]);

        return event;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } on Exception {
      return null;
    }
    return null;
  }
}
