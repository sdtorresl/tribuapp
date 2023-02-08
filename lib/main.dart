import 'package:bmwapp/bloc/provider.dart';
import 'package:bmwapp/core/app_theme.dart';
import 'package:bmwapp/pages/login_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return Provider(
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: lightTheme,
        initialRoute: _initialRoute(),
        routes: {
          /*         'home': (BuildContext context) => HomePage(),
          'onboarding': (BuildContext context) => OnboardingPage(),
          'transmission': (context) => TransmissionPage(),
          'documents': (context) => DocumentsPage(),
          'video-posters': (context) => PostersPage(),
          'video-posters-poll': (context) => PostersPollPage(), */
          'login': (BuildContext context) => const LoginPage(),
        },
      ),
    );
  }

  String _initialRoute() {
    return 'login';
    /* if (prefs.onboardingViewed == true) {
      if (prefs.token != null) {
        return 'home';
      } else {
        return 'login';
      }
    } else {
      return 'onboarding';
    } */
  }
}
