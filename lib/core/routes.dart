import 'package:flutter/material.dart';

import '../pages/documents_page.dart';
import '../pages/home_page.dart';
import '../pages/login_page.dart';
import '../pages/onboarding_page.dart';
import '../pages/posters_page.dart';
import '../pages/posters_poll_page.dart';

Map<String, WidgetBuilder> get routes {
  return {
    'home': (BuildContext context) => const HomePage(),
    'onboarding': (BuildContext context) => const OnboardingPage(),
    'documents': (context) => const DocumentsPage(),
    'video-posters': (context) => const PostersPage(),
    'video-posters-poll': (context) => const PostersPollPage(),
    'login': (BuildContext context) => const LoginPage(),
  };
}
