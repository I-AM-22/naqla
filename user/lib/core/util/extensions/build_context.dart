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

  //* Navigate stuff *//
//   NavigatorState get navigator => Navigator.of(this);
//   void pop<T extends Object>([T? result]) => navigator.pop<T>(result);
//
//   void popUntil({numberOfPages = 1}) {
//     int count = 0;
//     navigator.popUntil((_) => count++ == numberOfPages);
//   }
//
//   // Future<T?> pushNamed<T extends Object?>(
//   //   String routeName, {
//   //   Object? arguments,
//   // }) =>
//   //     navigator.pushNamed<T>(routeName, arguments: arguments);
//
//   Future<T?> pushPage<T extends Object>(Widget widget) =>
//       navigator.push<T>(MaterialPageRoute(builder: (_) => widget));
//
//   Future<T?> cupertinoPushPage<T extends Object>(Widget widget) =>
//       navigator.push<T>(CupertinoPageRoute(builder: (_) => widget));
//
//   Future<T?> pushNamedAndRemoveUntil<T extends Object?>(
//     String newRouteName,
//     RoutePredicate predicate, {
//     Object? arguments,
//   }) =>
//       navigator.pushNamedAndRemoveUntil<T>(
//         newRouteName,
//         predicate,
//         arguments: arguments,
//       );
}
