import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

part 'font.dart';

TextTheme appTextTheme(BuildContext context, TextTheme base, Color textColor) {
  return base
      .copyWith(
        displayLarge: base.displayLarge?.copyWith(
          fontSize: _FontSize.displayLarge,
          fontFamily: 'Mont',
          fontWeight: _regular,
          letterSpacing: -0.25,
        ),
        displayMedium: base.displayMedium?.copyWith(
          fontSize: _FontSize.displayMedium,
          fontFamily: 'Mont',
          fontWeight: _regular,
        ),
        displaySmall: base.displaySmall?.copyWith(
          fontSize: _FontSize.displaySmall,
          fontFamily: 'Mont',
          fontWeight: _regular,
        ),
        headlineLarge: base.headlineLarge?.copyWith(
          fontSize: _FontSize.headlineLarge,
          fontFamily: 'Mont',
          fontWeight: _regular,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          fontSize: _FontSize.headlineMedium,
          fontFamily: 'Mont',
          fontWeight: _regular,
        ),
        headlineSmall: base.headlineSmall?.copyWith(
          fontSize: _FontSize.headlineSmall,
          fontFamily: 'Mont',
          fontWeight: _regular,
        ),
        titleLarge: base.titleLarge?.copyWith(
          fontSize: _FontSize.titleLarge,
          fontWeight: _regular,
          fontFamily: 'Mont',
        ),
        titleMedium: base.titleMedium?.copyWith(
          fontSize: _FontSize.titleMedium,
          fontWeight: _medium,
          fontFamily: 'Mont',
          letterSpacing: 0.15,
        ),
        titleSmall: base.titleSmall?.copyWith(
          fontSize: _FontSize.titleSmall,
          fontWeight: _medium,
          fontFamily: 'Mont',
          letterSpacing: 0.1,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          fontSize: _FontSize.bodyLarge,
          fontWeight: _regular,
          fontFamily: 'Mont',
          letterSpacing: 0.5,
        ),
        bodyMedium: base.bodyMedium?.copyWith(
          fontSize: _FontSize.bodyMedium,
          fontWeight: _regular,
          fontFamily: 'Mont',
          letterSpacing: 0.25,
        ),
        bodySmall: base.bodySmall?.copyWith(
          fontSize: _FontSize.bodySmall,
          fontWeight: _regular,
          fontFamily: 'Mont',
          letterSpacing: 0.4,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontSize: _FontSize.labelLarge,
          fontFamily: 'Mont',
          fontWeight: _medium,
          letterSpacing: 0.1,
        ),
        labelMedium: base.labelMedium?.copyWith(
          fontSize: _FontSize.labelMedium,
          fontWeight: _medium,
          fontFamily: 'Mont',
          letterSpacing: 0.5,
        ),
        labelSmall: base.labelSmall?.copyWith(
          fontSize: _FontSize.labelSmall,
          fontWeight: _medium,
          fontFamily: 'Mont',
          letterSpacing: 0.5,
        ),
      )
      .apply(displayColor: textColor, bodyColor: textColor);
}
