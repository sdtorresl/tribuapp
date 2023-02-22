import 'package:flutter/material.dart';

class Onboarding extends StatelessWidget {
  final String title;
  final String description;
  final String picture;

  const Onboarding({
    Key? key,
    required this.title,
    required this.description,
    required this.picture,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        padding: const EdgeInsets.all(25),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const SizedBox(height: 125),
            Text(
              title,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displayMedium
                  ?.copyWith(color: Colors.black, fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 18),
            Text(
              description,
              textAlign: TextAlign.center,
              style: Theme.of(context)
                  .textTheme
                  .displaySmall
                  ?.copyWith(color: Colors.black, fontSize: 18),
            ),
            const SizedBox(height: 27),
            Image.asset(picture),
          ],
        ),
      ),
    );
  }
}
