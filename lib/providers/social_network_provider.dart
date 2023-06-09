import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;
import '../models/social_network_model.dart';

class SocialNetworkProvider {
  final String _url =
      GlobalConfiguration().getValue("api_url") + "/json-redes-sociales";

  Future<SocialNetworkModel?> getSocialNetworks() async {
    try {
      var response = await http.get(Uri.parse(_url));

      log(response.body);

      if (response.statusCode == 200) {
        log(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);

        SocialNetworkModel socialNetwork =
            SocialNetworkModel.fromMap(jsonResponse[0]['social-networks']);

        return socialNetwork;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('Error fetching social networks', error: e.toString());
    }

    return null;
  }
}
