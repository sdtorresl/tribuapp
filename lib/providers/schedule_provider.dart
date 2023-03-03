import 'dart:convert' as json;
import 'dart:developer';

import 'package:global_configuration/global_configuration.dart';

import '../models/schedule_model.dart';
import 'package:http/http.dart' as http;

class ScheduleProvider {
  final String _url = GlobalConfiguration().getValue("api_url");

  Future<List<ScheduleModel>> getSchedule() async {
    try {
      String scheduleUrl = "$_url/json-sesiones";
      var response = await http.get(Uri.parse(scheduleUrl));

      if (response.statusCode == 200) {
        log(response.body);
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        List<ScheduleModel> schedules = [];

        for (var item in jsonResponse) {
          ScheduleModel schedule = ScheduleModel.fromMap(item);
          schedules.add(schedule);
        }

        return schedules;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } catch (e) {
      log('Error getting schedule', error: e);
    }

    return [];
  }

  Future<String> getPdf() async {
    try {
      String scheduleUrl = "$_url/json-link-pdf";
      var response = await http.get(Uri.parse(scheduleUrl));

      if (response.statusCode == 200) {
        List<dynamic> jsonResponse = json.jsonDecode(response.body);
        String pdf = jsonResponse[0]["file"];
        pdf = pdf.isEmpty ? "" : _url + pdf;
        return pdf;
      } else {
        log('Request failed with status: ${response.statusCode}.');
      }
    } on Exception {
      log("Error getting PDF", error: Exception);
    }

    return "";
  }
}
