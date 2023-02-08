import 'package:flutter/material.dart';

import 'color_schemes.dart';

TextTheme textTheme = const TextTheme(
  headline1: TextStyle(
      fontSize: 22.0, fontFamily: 'PoppinsMedium', fontWeight: FontWeight.bold),
  headline2: TextStyle(
    fontSize: 20.0,
    fontFamily: 'PoppinsMedium',
    fontWeight: FontWeight.bold,
  ),
  headline3: TextStyle(
    fontSize: 20.0,
    fontFamily: 'Poppins',
  ),
  headline4: TextStyle(fontSize: 18.0, fontFamily: 'MontserratRegular'),
  headline5: TextStyle(fontSize: 14.0, fontFamily: 'MontserratLight'),
  bodyText1: TextStyle(
    fontSize: 18.0,
    fontFamily: 'MontserratLight',
  ),
  bodyText2: TextStyle(
    fontSize: 16.0,
    fontFamily: 'MontserratRegular',
  ),
  subtitle1: TextStyle(
    fontSize: 18.0,
    fontFamily: 'MontserratMedium',
  ),
  subtitle2: TextStyle(fontSize: 14.0, fontFamily: 'MontserratRegular'),
  caption: TextStyle(
    fontSize: 25.0,
    fontFamily: 'MontserratMedium',
  ),
);

ThemeData lightTheme = ThemeData.light().copyWith(
  useMaterial3: true,
  colorScheme: lightColorScheme,
  textTheme: textTheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      textStyle: const TextStyle(
        fontSize: 20,
        fontFamily: 'Poppins',
      ),
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
    ),
  ),
);
