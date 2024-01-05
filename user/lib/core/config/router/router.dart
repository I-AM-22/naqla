import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/router/router_config.dart';
import 'package:user/features/auth/presentation/pages/registration/register_page.dart';
import 'package:user/features/auth/presentation/pages/set_location_page.dart';
import 'package:user/features/auth/presentation/pages/welcome_page.dart';
import 'package:user/features/on_boarding/presentation/pages/on_boarding_screen.dart';
import 'package:user/features/welcome/splash.dart';

import '../../../features/auth/presentation/pages/registration/phone_verfication.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _homeNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'home');
GlobalKey<NavigatorState> get rootNavigatorKey => _rootNavigatorKey;
GlobalKey<NavigatorState> get homeNavigatorKey => _homeNavigatorKey;

class GRouter {
  static GoRouter get router => _router;

  static RouterConfiguration get config => _config;

  static final RouterConfiguration _config = RouterConfiguration.init();

  static final GoRouter _router = GoRouter(
      initialLocation: _config.splashScreen,
      navigatorKey: _rootNavigatorKey,
      routes: <RouteBase>[
        GoRoute(
            path: _config.splashScreen,
            name: _config.splashScreen,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _builderPage(child: const SplashScreen(), state: state);
            }),
        GoRoute(
            path: _config.onBoardingRoutes.onBoarding,
            name: _config.onBoardingRoutes.onBoarding,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _builderPage(
                  child: const OnBoardingScreen(), state: state);
            }),
        GoRoute(
            path: _config.authRoutes.setLocation,
            name: _config.authRoutes.setLocation,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _builderPage(child: const SetLocationPage(), state: state);
            }),
        GoRoute(
            path: _config.authRoutes.welcome,
            name: _config.authRoutes.welcome,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _builderPage(child: const WelcomePage(), state: state);
            }),
        GoRoute(
          path: RegisterPage.path,
          name: RegisterPage.name,
          builder: (context, state) => const RegisterPage(),
        ),
        GoRoute(
          path: PhoneVerificationPage.path,
          name: PhoneVerificationPage.name,
          builder: (context, state) => const PhoneVerificationPage(),
        ),
      ]);

  static Page<dynamic> _builderPage<T>(
      {required Widget child, required GoRouterState state}) {
    if (Platform.isIOS) {
      return CupertinoPage<T>(child: child, key: state.pageKey);
    } else {
      return MaterialPage<T>(child: child, key: state.pageKey);
    }
  }
}
