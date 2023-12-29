import 'package:flutter/material.dart';

extension BuildContextExtension on BuildContext {
  //* THEME STUFF *//
  ThemeData get theme => Theme.of(this);
  TextTheme get textTheme => theme.textTheme;
  ColorScheme get colorScheme => theme.colorScheme;

  //* Media query stuff *//
  MediaQueryData get mediaQuery => MediaQuery.of(this);
  double get fullWidth => mediaQuery.size.width;
  double get fullHeight => mediaQuery.size.height;
}
