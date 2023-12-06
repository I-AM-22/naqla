import 'package:flutter/material.dart';

abstract class AppColors {
  const AppColors._();

  static const MaterialColor primary = MaterialColor(
    _primaryPrimaryValue,
    <int, Color>{
      500: Color(_primaryPrimaryValue),
    },
  );

  static const int _primaryPrimaryValue = 0xFF6D28D9;

  static const MaterialColor dark = MaterialColor(
    _darkPrimaryValue,
    <int, Color>{
      500: Color(_darkPrimaryValue),
    },
  );

  static const int _darkPrimaryValue = 0xFF6D28D9;

  static const MaterialColor grey = MaterialColor(
    _greyPrimaryValue,
    <int, Color>{
      50: Color(0xfffdfbff),
      100: Color(0xffd6d5d6),
      200: Color(0xffB0B4BD),
      300: Color(0xffa6a3a6),
      400: Color(0xff959195),
      500: Color(_greyPrimaryValue),
      600: Color(0xff6f6b6f),
      700: Color(0xff575457),
      800: Color(0xff434143),
      900: Color(0xff333233),
    },
  );

  static const int _greyPrimaryValue = 0xff7a767a;

  static const Color backgroundDark = Colors.black;
  static const Color green = Color(0xFF4ADA63);
  static const Color greenAccentCart = Color(0xFF9ED899);
  static const Color blueAccentStatus = Color(0xFF6FADED);
  static const Color blueStatus = Color(0xFF004D9C);
  static const Color redStatus = Color(0xFFFF2929);
  static const Color orangeStatus = Color(0xffF3A638);
}

Color darken(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

Color lighten(Color color, [double amount = .1]) {
  assert(amount >= 0 && amount <= 1);

  final hsl = HSLColor.fromColor(color);
  final hslLight = hsl.withLightness((hsl.lightness + amount).clamp(0.0, 1.0));

  return hslLight.toColor();
}
