import 'package:flutter/material.dart';

extension MyColorScheme on ColorScheme {
  MaterialColor get red => const MaterialColor(
        _primaryGreyValue,
        <int, Color>{
          50: Color(0xFFFFEBEE),
          100: Color(0xFFFFCDD2),
          200: Color(0xFFEF9A9A),
          300: Color(0xFFE57373),
          400: Color(0xFFEF5350),
          500: Color(0xFFF44336),
          600: Color(0xFFE53935),
          700: Color(0xFFD32F2F),
          800: Color(0xFFC62828),
          900: Color(0xFFB71B1C)
        },
      );

  MaterialColor get systemGrey => const MaterialColor(
        _primaryGreyValue,
        <int, Color>{
          50: Color(0xFFF7F7F7),
          100: Color(0xFFE8E8E8),
          200: Color(0xFFD0D0D0),
          300: Color(0xFFB8B8B8),
          400: Color(_primaryGreyValue),
          500: Color(0xFF898989),
          600: Color(0xFF717171),
          700: Color(0xFF5A5A5A),
          800: Color(0xFF414141),
          900: Color(0xFF2A2A2A)
        },
      );

  MaterialColor get success => const MaterialColor(0xFF4CAF51, <int, Color>{
        50: Color(0xFFE8F5E9),
        100: Color(0xFFC8E6C9),
        200: Color(0xFFA5D6A7),
        300: Color(0xFF81C784),
        400: Color(0xFF66BB6B),
        500: Color(0xFF4CAF51),
        600: Color(0xFF43A048),
        700: Color(0xFF388E3D),
        800: Color(0xFF2E7D33),
        900: Color(0xFF1B5E21)
      });

  static const int _primaryGreyValue = 0xFFA0A0A0;

  static const MaterialColor _blackPrimary = MaterialColor(
    _blackPrimaryValue,
    <int, Color>{},
  );

  static const int _blackPrimaryValue = 0xff1f6e1a;

  static const MaterialColor _hint = MaterialColor(
    _primaryHintValue,
    <int, Color>{
      100: Color(0xffF2F3F3),
    },
  );

  static const int _primaryHintValue = 0xffADADAD;

  static const MaterialColor _drawer = MaterialColor(
    _primaryDrawerValue,
    <int, Color>{},
  );

  static const int _primaryDrawerValue = 0xff2A2E43;

  static const MaterialColor _white = MaterialColor(
    _primaryWhiteValue,
    <int, Color>{},
  );

  static const int _primaryWhiteValue = 0xffFEFEFE;

  MaterialColor get hint => brightness == Brightness.light ? _hint : _hint;

  Color get grey150 => const Color(0xffE1E1E1);

  Color get drawer => brightness == Brightness.light ? _drawer : _drawer;

  Color get white => brightness == Brightness.light ? _white : _white;

  Color get dividerColor => const Color(0xffDFDFDF);

  Color get black => const Color(0xff000000);

  Color get warning => const Color(0xFFFB8A00);

  Color get blue => const Color(0xff0080FF);

  Color getColor({required Color light, required Color dark}) =>
      brightness == Brightness.light ? light : dark;
}
