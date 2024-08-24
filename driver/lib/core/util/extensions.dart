import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

extension ListExtension<T> on List<T> {
  String toJson(Map<String, dynamic> Function(T instance) toJson) =>
      jsonEncode(map((e) => toJson(e)).toList());
}

extension MapExtension<K, V> on Map<K, V> {
  Map<int, V> setState(int index, V newState) =>
      Map<int, V>.from(this)..[index] = newState;
}

extension BuildContextExtension on BuildContext {
  //* THEME STUFF *//
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  //* Media query stuff *//
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get fullWidth => mediaQuery.size.width;
  double get fullHeight => mediaQuery.size.height;

  get locale => Localizations.localeOf(this);

  get isArabic => locale == const Locale('ar', 'SY');

  double get bodyHeight {
    Size size = mediaQuery.size;
    double statusBar = mediaQuery.viewPadding.top;
    double kLeadingWidth = kToolbarHeight;
    double bottomBar = mediaQuery.viewInsets.bottom;
    double bottomPadding = mediaQuery.viewPadding.bottom;
    double bottomSafeArea = mediaQuery.padding.bottom;
    return size.height -
        statusBar -
        kLeadingWidth -
        bottomBar -
        bottomPadding -
        bottomSafeArea;
  }
}

extension FigmaDimension on num {
  ///use this to get font height to set in text from flutter
  double fromFigmaHeight(double fontSize) {
    return h / fontSize.sp;
  }
}
