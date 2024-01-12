import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/config/themes/my_color_scheme.dart';

import 'colors_app.dart';

ElevatedButtonThemeData _elevatedButtonTheme(
        ColorScheme scheme, TextTheme textTheme) =>
    ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        textStyle: textTheme.titleMedium,
        backgroundColor: scheme.primary,
        foregroundColor: scheme.onPrimary,
        disabledBackgroundColor: scheme.systemGray.shade50,
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

final double kbrDefault = 12.r;
final double kbrBorderTextField = 8.r;
final double kbrButton = 6.r;

const kDesignSize = Size(428, 923);
const double kpPaddingPage = 16;
