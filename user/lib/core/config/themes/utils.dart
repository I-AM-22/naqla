part of 'app_theme.dart';

ElevatedButtonThemeData _elevatedButtonTheme(
        ColorScheme scheme, TextTheme textTheme) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: textTheme.titleMedium?.sb,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        disabledBackgroundColor: scheme.grey50,
        minimumSize: Size(double.infinity, 50.h),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kbrBorderTextField)),
      ),
    );

TextButtonThemeData _textButtonTheme(ColorScheme scheme, TextTheme textTheme) =>
    TextButtonThemeData(
      style: ElevatedButton.styleFrom(
          textStyle: textTheme.labelLarge,
          foregroundColor: AppColors.grey.shade600,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kbrBorderTextField),
          ),
          shadowColor: scheme.primary.withOpacity(0.2)),
    );

AppBarTheme _appBarTheme(ThemeData theme, ColorScheme scheme,
        TextTheme textTheme, ThemeMode themeMode) =>
    theme.appBarTheme.copyWith(
        backgroundColor: scheme.background,
        titleTextStyle: textTheme.headlineSmall,
        systemOverlayStyle: themeMode == ThemeMode.dark
            ? SystemUiOverlayStyle.light
            : SystemUiOverlayStyle.dark,
        elevation: 0.0,
        surfaceTintColor: scheme.surface);

DividerThemeData _dividerTheme(ThemeData theme, ColorScheme scheme) =>
    theme.dividerTheme
        .copyWith(color: AppColors.grey.withOpacity(0.2), thickness: 1);

BottomSheetThemeData _bottomSheetThemeData(ThemeData theme) =>
    theme.bottomSheetTheme.copyWith(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(kbrDefault),
        ),
      ),
      backgroundColor: theme.colorScheme.background,
    );

final double kbrDefault = 15.r;
final double kbrBorderTextField = 5.r;
final double kbrButton = 6.r;

const kDesignSize = Size(428, 923);
const double kpPaddingPage = 20;

////// *** Sh ***
// ///
final double ksh4 = 4.h;
final double ksh8 = 8.h;
final double ksh12 = 12.h;
final double ksh16 = 16.h;
final double ksh24 = 24.h;
final double ksh32 = 32.h;
final double ksh40 = 40.h;
final double ksh48 = 48.h;
final double ksh64 = 64.h;
final double ksh80 = 80.h;
final double ksh96 = 96.h;
final double ksh112 = 112.h;
final double ksh144 = 144.h;
final double ksh176 = 176.h;
final double ksh208 = 208.h;
final double ksh240 = 240.h;

/// *** Sw ***
///
final double ksw4 = 4.w;
final double ksw8 = 8.w;
final double ksw12 = 12.w;
final double ksw16 = 16.w;
final double ksw24 = 24.w;
final double ksw32 = 32.w;
final double ksw40 = 40.w;
final double ksw48 = 48.w;
final double ksw64 = 64.w;
final double ksw80 = 80.w;
final double ksw96 = 96.w;
final double ksw112 = 112.w;
final double ksw144 = 144.w;
final double ksw176 = 176.w;
final double ksw208 = 208.w;
final double ksw240 = 240.w;

/// *** Sp ***
///
final double ksp4 = 4.sp;
final double ksp8 = 8.sp;
final double ksp12 = 12.sp;
final double ksp16 = 16.sp;
final double ksp24 = 24.sp;
final double ksp32 = 32.sp;
final double ksp40 = 40.sp;
final double ksp48 = 48.sp;
final double ksp64 = 64.sp;
final double ksp80 = 80.sp;
final double ksp96 = 96.sp;
final double ksp112 = 112.sp;
final double ksp144 = 144.sp;
final double ksp176 = 176.sp;
final double ksp208 = 208.sp;
final double ksp240 = 240.sp;

/// *** R ***
///
final double kr4 = 4.r;
final double kr8 = 8.r;
final double kr12 = 12.r;
final double kr16 = 16.r;
final double kr24 = 24.r;
final double kr32 = 32.r;
final double kr40 = 40.r;
final double kr48 = 48.r;
final double kr64 = 64.r;
final double kr80 = 80.r;
final double kr96 = 96.r;
final double kr112 = 112.r;
final double kr144 = 144.r;
final double kr176 = 176.r;
final double kr208 = 208.r;
final double kr240 = 240.r;
