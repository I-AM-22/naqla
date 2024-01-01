import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

TextTheme appTextTheme(BuildContext context, TextTheme base, Color textColor) {
  return base
      .copyWith(
        displayLarge: base.displayLarge?.copyWith(
          fontSize: 57.sp,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
          letterSpacing: -0.25,
        ),
        displayMedium: base.displayMedium?.copyWith(
          fontSize: 36.sp,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
        ),
        displaySmall: base.displaySmall?.copyWith(
          fontSize: 32.sp,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w400,
        ),
        headlineLarge: base.headlineLarge?.copyWith(
          fontSize: 32.sp,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w600,
        ),
        headlineMedium: base.headlineMedium?.copyWith(
          fontSize: 28.sp,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w600,
        ),
        headlineSmall: base.headlineSmall?.copyWith(
          fontSize: 24.sp,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w600,
        ),
        titleLarge: base.titleLarge?.copyWith(
          fontSize: 22.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'poppins',
        ),
        titleMedium: base.titleMedium?.copyWith(
          fontSize: 20.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'poppins',
          letterSpacing: 0.15,
        ),
        titleSmall: base.titleSmall?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'poppins',
          letterSpacing: 0.1,
        ),
        bodyLarge: base.bodyLarge?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppins',
          letterSpacing: 0.5,
        ),
        bodyMedium: base.bodyMedium?.copyWith(
          fontSize: 16.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'poppins',
          letterSpacing: 0.25,
        ),
        bodySmall: base.bodySmall?.copyWith(
          fontSize: 12.sp,
          fontWeight: FontWeight.w400,
          fontFamily: 'poppins',
          letterSpacing: 0.4,
        ),
        labelLarge: base.labelLarge?.copyWith(
          fontSize: 18.sp,
          fontFamily: 'poppins',
          fontWeight: FontWeight.w500,
          letterSpacing: 0.1,
        ),
        labelMedium: base.labelMedium?.copyWith(
          fontSize: 14.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppins',
          letterSpacing: 0.5,
        ),
        labelSmall: base.labelSmall?.copyWith(
          fontSize: 11.sp,
          fontWeight: FontWeight.w500,
          fontFamily: 'poppins',
          letterSpacing: 0.5,
        ),
      )
      .apply(displayColor: textColor, bodyColor: textColor);
}

extension TextThemeExt on TextTheme {
  TextStyle get subHead => TextStyle(
        fontWeight: FontWeight.w500,
        fontSize: 16,
        fontFamily: 'poppins',
      );
}
