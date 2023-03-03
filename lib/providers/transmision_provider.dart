import 'dart:convert' as json;
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

import '../models/transmision_model.dart';

class TransmissionProvider {
  final String _url =
      GlobalConfiguration().getValue("api_url") + "/json-transmision";

  Future<TransmissionModel?> getTransmission(int? id) async {
    String endpoint = id == null ? '$_url/1' : '$_url/$id';

    try {
      var response = await http.get(Uri.parse(endpoint));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        TransmissionModel transmission =
            TransmissionModel.fromMap(jsonResponse[0]);

        return transmission;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('Error getting transmission', error: e);
    }

    return null;
  }
}
