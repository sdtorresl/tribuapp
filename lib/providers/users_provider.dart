import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:global_configuration/global_configuration.dart';

import '../models/users_model.dart';
import '../preferences/user_preferences.dart';

class UserProvider {
  final _prefs = UserPreferences();

  Future<UserModel?> login(String email, String code) async {
    final String url = GlobalConfiguration().getValue("api_url") + "/login";
    final String username = GlobalConfiguration().getValue("cms_user");
    final String password = GlobalConfiguration().getValue("cms_password");

    try {
      String encryptedCode = base64Encode(
        utf8.encode(code),
      );

      final String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';
      String body =
          json.encode({'email': email, 'code': encryptedCode, 'premium': "1"});

      var response = await http.post(
        Uri.parse(url),
        body: body,
        headers: <String, String>{
          'authorization': basicAuth,
          'content-type': 'application/json'
        },
      );

      switch (response.statusCode) {
        case 200:
          String token = json.decode(response.body)["token"];
          bool isPremium = json.decode(response.body)["flag"] == 1;
          _prefs.isPremium = isPremium;

          UserModel? user = await getUser(token);
          return user;
        default:
      }
    } catch (e) {
      log("Error on authentication", error: e);
    }
    return null;
  }

  Future<UserModel?> getUser(String token) async {
    final String url =
        GlobalConfiguration().getValue("api_url") + "/usuarios/" + token;

    try {
      final String username = GlobalConfiguration().getValue("cms_user");
      final String password = GlobalConfiguration().getValue("cms_password");

      String basicAuth =
          'Basic ${base64Encode(utf8.encode('$username:$password'))}';

      var response = await http.get(
        Uri.parse(url),
        headers: <String, String>{
          'authorization': basicAuth,
          'content-type': 'application/json'
        },
      );

      UserModel user = UserModel.fromJson(response.body);
      _prefs.token = token;

      return user;
    } catch (e) {
      log("Error on getting logged user", error: e);

      return null;
    }
  }
}
