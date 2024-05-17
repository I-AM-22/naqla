import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../features/auth/presentation/pages/phone_verfication.dart';
import '../../../features/auth/presentation/pages/sign_in_page.dart';
import '../../../features/welcome/splash.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shell1NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell1');

final GlobalKey<NavigatorState> _shell2NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell2');

final GlobalKey<NavigatorState> _shell3NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell3');

final GlobalKey<NavigatorState> _shell4NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell4');

class GRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(initialLocation: SplashScreen.path, navigatorKey: _rootNavigatorKey, routes: <RouteBase>[
    GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return _builderPage(child: const SplashScreen(), state: state);
        }),
    GoRoute(
        path: SignInPage.path,
        name: SignInPage.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return _builderPage(child: const SignInPage(), state: state);
        }),
    GoRoute(
        path: PhoneVerificationPage.path,
        name: PhoneVerificationPage.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return _builderPage(
              child: PhoneVerificationPage(
                param: state.extra as PhoneVerificationParam,
              ),
              state: state);
        }),
  ]);

  static Page<dynamic> _builderPage<T>({required Widget child, required GoRouterState state}) {
    if (Platform.isIOS) {
      return CupertinoPage<T>(child: child, key: state.pageKey);
    } else {
      return MaterialPage<T>(child: child, key: state.pageKey);
    }
  }
}
