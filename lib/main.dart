import 'package:tribuapp/bloc/provider.dart';
import 'package:tribuapp/core/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:tribuapp/preferences/user_preferences.dart';
import 'package:global_configuration/global_configuration.dart';

import 'core/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("settings.json");
  await UserPreferences.init();
  runApp(TribuApp());
}

class TribuApp extends StatelessWidget {
  TribuApp({super.key});

  final prefs = UserPreferences();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        initialRoute: _initialRoute(),
        routes: routes,
      ),
    );
  }

  String _initialRoute() {
    if (prefs.onBoardingViewed == true) {
      if (prefs.token != null) {
        return 'home';
      } else {
        return 'login';
      }
    } else {
      return 'onboarding';
    }
  }
}
