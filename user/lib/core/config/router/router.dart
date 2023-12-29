import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/router/router_config.dart';
import 'package:user/features/on_boarding/presentation/pages/on_boarding_screen.dart';
import 'package:user/features/welcome/splash.dart';

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
            })
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
