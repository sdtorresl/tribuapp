import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';
import 'package:http/http.dart' as http;
import 'dart:convert' as json;

import '../models/shcedule_category_model.dart';

class CategoriesProvider {
  final String _url =
      GlobalConfiguration().getValue("api_url") + "/json-sesiones-categorias";

  Future<List<ScheduleCategoryModel>> getCategory() async {
    try {
      var response = await http.get(Uri.parse(_url));

      if (response.statusCode == 200) {
        log(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        return jsonResponse
            .map((e) => ScheduleCategoryModel.fromMap(e))
            .toSet()
            .toList();
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } on Exception {
      log('Error getting categories', error: Exception);
    }

    return [];
  }
}
