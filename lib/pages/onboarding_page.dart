import 'package:flutter/material.dart';

import 'package:bmwapp/common/onboarding_view.dart';
import 'package:bmwapp/preferences/user_preferences.dart';
import 'package:carousel_slider/carousel_slider.dart';

class OnboardingPage extends StatefulWidget {
  const OnboardingPage({super.key});

  @override
  State<StatefulWidget> createState() {
    return _OnboardingPageState();
  }
}

class _OnboardingPageState extends State<OnboardingPage> {
  int _current = 0;
  final List<Widget> carouselItems = [
    const Onboarding(
      title: 'Aquí tendrás acceso al #SeminarioIcfes',
      description: 'Disfruta de este espacio que hemos creado para ti',
      picture: 'assets/img/Bitmap.png',
    ),
    const Onboarding(
      title: 'Un evento completo al alcance de tu mano',
      description: 'Conéctate a través de tu celular',
      picture: 'assets/img/Bitmap2.png',
    ),
    const Onboarding(
      title: 'Conferencias y conversatorios sobre educación',
      description: '¡Participa y comparte en redes sociales!',
      picture: 'assets/img/Bitmap3.png',
    ),
  ];
  final CarouselController _controller = CarouselController();

  @override
  Widget build(BuildContext context) {
    final prefs = UserPreferences();

    return Scaffold(
      body: Column(
        children: [
          SafeArea(
            child: Container(
              margin: const EdgeInsets.only(top: 40),
              alignment: Alignment.bottomRight,
              height: 30,
              child: FloatingActionButton(
                heroTag: 'close-button',
                elevation: 5.0,
                child: const Icon(
                  Icons.clear,
                  color: Colors.white,
                ),
                onPressed: () {
                  prefs.onboardingViewed = true;
                  Navigator.of(context).pushNamed('login');
                },
              ),
            ),
          ),
          CarouselSlider(
            items: carouselItems,
            options: CarouselOptions(
              autoPlay: false,
              enlargeCenterPage: false,
              aspectRatio: 0.9,
              viewportFraction: 1,
              onPageChanged: (index, reason) {
                setState(
                  () {
                    _current = index;
                  },
                );
              },
            ),
            carouselController: _controller,
          ),
          const SizedBox(height: 75),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: carouselItems.map((item) {
              int index = carouselItems.indexOf(item);
              return Container(
                width: 15.0,
                height: 15.0,
                margin:
                    const EdgeInsets.symmetric(vertical: 0, horizontal: 2.0),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: _current == index
                      ? const Color.fromRGBO(255, 0, 128, 0.9)
                      : const Color.fromRGBO(255, 0, 111, 0.5),
                ),
              );
            }).toList(),
          ),
          const SizedBox(height: 30),
          Container(
            width: 60,
            margin: const EdgeInsets.only(bottom: 10),
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                FloatingActionButton(
                  elevation: 5.0,
                  onPressed: _current == carouselItems.length - 1
                      ? () {
                          prefs.onboardingViewed = true;
                          Navigator.of(context).pushNamed('login');
                        }
                      : () => _controller.nextPage(),
                  child: const Icon(
                    Icons.navigate_next,
                    color: Colors.white,
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
