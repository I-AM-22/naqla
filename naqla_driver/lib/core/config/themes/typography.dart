part of 'app_theme.dart';

TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(fontFamily: 'noor', fontSize: 57.0.sp, fontWeight: FontWeight.w400),
  displayMedium: TextStyle(fontFamily: 'noor', fontSize: 32.0.sp, fontWeight: FontWeight.w400, height: 40.fromFigmaHeight(32)),
  displaySmall: TextStyle(fontFamily: 'noor', fontSize: 36.0.sp, fontWeight: FontWeight.w400),

  /// headline
  headlineLarge: TextStyle(
    fontFamily: 'noor',
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF2A2A2A),
    height: 1.2,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'noor',
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF2A2A2A),
    height: 25.fromFigmaHeight(18),
  ),
  headlineSmall: TextStyle(
    fontFamily: 'noor',
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w500,
    letterSpacing: -0.5.w,
    color: const Color(0xFF2A2A2A),
    height: 25.fromFigmaHeight(18),
  ),

  ///Title
  titleLarge: TextStyle(fontFamily: 'noor', fontSize: 22.0.sp, fontWeight: FontWeight.w400),
  titleMedium: TextStyle(fontFamily: 'noor', fontSize: 28.0.sp, fontWeight: FontWeight.w500, height: 34.fromFigmaHeight(28)),
  titleSmall: TextStyle(fontFamily: 'noor', fontSize: 16.0.sp, fontWeight: FontWeight.w500),

  ///Label
  labelLarge: TextStyle(fontFamily: 'noor', fontSize: 14.0.sp, fontWeight: FontWeight.w500),
  labelMedium: TextStyle(
    fontFamily: 'noor',
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w500,
    height: 16.fromFigmaHeight(12),
  ),
  labelSmall: TextStyle(fontFamily: 'noor', fontSize: 11.0.sp, fontWeight: FontWeight.w500),

  ///Body
  bodyLarge: TextStyle(fontFamily: 'noor', fontSize: 16.0.sp, fontWeight: FontWeight.w400, height: 18.fromFigmaHeight(16)),
  bodyMedium: TextStyle(
    fontFamily: 'noor',
    fontSize: 12.0.sp,
    fontWeight: FontWeight.w500,
    height: 18.fromFigmaHeight(12),
  ),
  bodySmall: TextStyle(fontFamily: 'noor', fontSize: 12.0.sp, fontWeight: FontWeight.w400),
);

extension TextThemeExt on TextTheme {
  ///Subhead/sm/SH-sm-medium
  TextStyle get subHeadRegular => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        height: 23.fromFigmaHeight(16),
        fontFamily: 'noor',
      );

  TextStyle get subHeadMedium => TextStyle(fontFamily: 'noor', fontWeight: FontWeight.w500, fontSize: 14.sp, height: 19.fromFigmaHeight(14));

  TextStyle get subHeadWebMedium =>
      TextStyle(fontFamily: 'noor', fontWeight: FontWeight.w500, fontSize: 16.sp, color: const Color(0xFFA0A0A0), height: 23.fromFigmaHeight(16));

  TextStyle get bodyRegular =>
      TextStyle(fontFamily: 'noor', fontWeight: FontWeight.w400, fontSize: 16.sp, color: const Color(0xFFA0A0A0), height: 24.fromFigmaHeight(16));

  TextStyle get bodySmMedium =>
      TextStyle(fontFamily: 'noor', fontWeight: FontWeight.w500, fontSize: 12.sp, color: const Color(0xFF898989), height: 18.fromFigmaHeight(12));
}

extension FamilyUtils on TextStyle {
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
}
