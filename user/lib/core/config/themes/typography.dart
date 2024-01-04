part of 'app_theme.dart';

TextTheme textTheme = TextTheme(
  displayLarge: TextStyle(
      fontFamily: 'poppins', fontSize: 57.0.sp, fontWeight: FontWeight.w400),
  displayMedium: TextStyle(
      fontFamily: 'poppins',
      fontSize: 32.0.sp,
      fontWeight: FontWeight.w400,
      height: 40.fromFigmaHeight(32)),
  displaySmall: TextStyle(
      fontFamily: 'poppins', fontSize: 36.0.sp, fontWeight: FontWeight.w400),

  /// headline
  headlineLarge: TextStyle(
    fontFamily: 'poppins',
    fontSize: 32.sp,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF2A2A2A),
    height: 1.2,
  ),
  headlineMedium: TextStyle(
    fontFamily: 'poppins',
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w600,
    color: const Color(0xFF2A2A2A),
    height: 25.fromFigmaHeight(28),
  ),
  headlineSmall: TextStyle(
    fontFamily: 'poppins',
    fontSize: 24.0.sp,
    fontWeight: FontWeight.w600,
    letterSpacing: -0.5.w,
    color: const Color(0xFF2A2A2A),
    height: 32.fromFigmaHeight(24),
  ),

  ///Title
  titleLarge: TextStyle(
      fontFamily: 'poppins', fontSize: 22.0.sp, fontWeight: FontWeight.w400),
  titleMedium: TextStyle(
      fontFamily: 'poppins',
      fontSize: 24.0.sp,
      fontWeight: FontWeight.w500,
      height: 30.fromFigmaHeight(24)),
  titleSmall: TextStyle(
      fontFamily: 'poppins', fontSize: 16.0.sp, fontWeight: FontWeight.w500),

  ///Label
  labelLarge: TextStyle(
      fontFamily: 'poppins', fontSize: 14.0.sp, fontWeight: FontWeight.w500),
  labelMedium: TextStyle(
    fontFamily: 'poppins',
    fontSize: 18.0.sp,
    fontWeight: FontWeight.w500,
    height: 24.fromFigmaHeight(18),
  ),
  labelSmall: TextStyle(
      fontFamily: 'poppins', fontSize: 11.0.sp, fontWeight: FontWeight.w500),

  ///Body
  bodyLarge: TextStyle(
      fontFamily: 'poppins', fontSize: 16.0.sp, fontWeight: FontWeight.w400),
  bodyMedium: TextStyle(
    fontFamily: 'poppins',
    fontSize: 16.0.sp,
    fontWeight: FontWeight.w500,
    height: 24.fromFigmaHeight(16),
  ),
  bodySmall: TextStyle(
      fontFamily: 'poppins', fontSize: 12.0.sp, fontWeight: FontWeight.w400),
);

extension TextThemeExt on TextTheme {
  ///Subhead/sm/SH-sm-medium
  TextStyle get subHeadRegular => TextStyle(
        fontWeight: FontWeight.w400,
        fontSize: 16.sp,
        height: 23.fromFigmaHeight(16),
        fontFamily: 'poppins',
      );

  TextStyle get subHeadMedium => TextStyle(
      fontFamily: 'poppins',
      fontWeight: FontWeight.w500,
      fontSize: 14.sp,
      height: 19.fromFigmaHeight(14));

  TextStyle get subHeadWebMedium => TextStyle(
      fontFamily: 'poppins',
      fontWeight: FontWeight.w500,
      fontSize: 16.sp,
      color: const Color(0xFFA0A0A0),
      height: 23.fromFigmaHeight(16));

  TextStyle get bodyRegular => TextStyle(
      fontFamily: 'poppins',
      fontWeight: FontWeight.w400,
      fontSize: 16.sp,
      color: const Color(0xFFA0A0A0),
      height: 24.fromFigmaHeight(16));
}

extension FamilyUtils on TextStyle {
  TextStyle get extraBold => copyWith(fontWeight: FontWeight.w800);

  TextStyle get bold => copyWith(fontWeight: FontWeight.bold);

  TextStyle get semiBold => copyWith(fontWeight: FontWeight.w600);

  TextStyle get medium => copyWith(fontWeight: FontWeight.w500);

  TextStyle get regular => copyWith(fontWeight: FontWeight.w400);

  TextStyle get light => copyWith(fontWeight: FontWeight.w300);
}
