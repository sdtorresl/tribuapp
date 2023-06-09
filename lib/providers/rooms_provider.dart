import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';
import 'package:tribuapp/models/room_model.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

class RoomsProvider {
  final String _url = GlobalConfiguration().getValue("api_url") + "/json-salas";

  Future<List<RoomModel>> getRooms() async {
    try {
      var response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        log(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<RoomModel> rooms = [];

        for (var item in jsonResponse) {
          RoomModel room = RoomModel.fromMap(item);
          rooms.add(room);
        }

        return rooms;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('error', error: e);
    }

    return [];
  }
}
