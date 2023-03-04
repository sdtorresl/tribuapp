import 'package:bmwapp/bloc/provider.dart';
import 'package:bmwapp/core/app_theme.dart';
import 'package:bmwapp/pages/login_page.dart';
import 'package:bmwapp/pages/home_page.dart';
import 'package:bmwapp/pages/posters_poll_page.dart';
import 'package:flutter/material.dart';
import 'package:bmwapp/preferences/user_preferences.dart';
import 'package:bmwapp/pages/onboarding_page.dart';
import 'package:bmwapp/pages/documents_page.dart';
import 'package:bmwapp/pages/posters_page.dart';
import 'package:global_configuration/global_configuration.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await GlobalConfiguration().loadFromAsset("settings.json");
  await UserPreferences.init();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final prefs = UserPreferences();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        initialRoute: _initialRoute(),
        routes: {
          'home': (BuildContext context) => const HomePage(),
          'onboarding': (BuildContext context) => const OnboardingPage(),
          //'transmission': (context) => const TransmissionPage(),
          'documents': (context) => const DocumentsPage(),
          'video-posters': (context) => const PostersPage(),
          'video-posters-poll': (context) => const PostersPollPage(),
          'login': (BuildContext context) => const LoginPage(),
        },
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
