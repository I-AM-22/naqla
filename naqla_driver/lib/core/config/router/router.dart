import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/features/home/presentation/pages/home_page.dart';
import 'package:naqla_driver/features/orders/presentation/pages/orders_page.dart';
import 'package:naqla_driver/features/profile/presentation/pages/profile_page.dart';

import '../../../features/app/presentation/pages/base_page.dart';
import '../../../features/auth/presentation/pages/phone_verfication.dart';
import '../../../features/auth/presentation/pages/sign_in_page.dart';
import '../../../features/welcome/splash.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shell1NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell1');

final GlobalKey<NavigatorState> _shell2NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell2');

final GlobalKey<NavigatorState> _shell3NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell3');

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
        path: SignUpPage.path,
        name: SignUpPage.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return _builderPage(child: const SignUpPage(), state: state);
        }),
    GoRoute(
      path: PhoneVerificationPage.path,
      name: PhoneVerificationPage.name,
      builder: (context, state) => PhoneVerificationPage(
        param: state.extra as PhoneVerificationParam,
      ),
      pageBuilder: (context, state) => CustomTransitionPage(
        child: PhoneVerificationPage(
          param: state.extra as PhoneVerificationParam,
        ),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
    ),
    GoRoute(
      path: SignUpPage.path,
      name: SignUpPage.name,
      builder: (context, state) => const SignUpPage(),
      pageBuilder: (context, state) => CustomTransitionPage(
        child: const SignUpPage(),
        transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
          position: Tween<Offset>(begin: const Offset(0, 1), end: Offset.zero).animate(animation),
          child: child,
        ),
      ),
    ),
    StatefulShellRoute.indexedStack(
        builder: (context, state, child) {
          var fullPath = GoRouter.of(context).routeInformationProvider.value.uri.path;
          return BasePage(
            fullPath: fullPath,
            child: child,
          );
        },
        branches: [
          StatefulShellBranch(initialLocation: HomePage.path, navigatorKey: _shell1NavigatorKey, routes: [
            GoRoute(
              path: HomePage.path,
              name: HomePage.name,
              builder: (context, state) => const HomePage(),
            )
          ]),
          StatefulShellBranch(initialLocation: OrdersPage.path, navigatorKey: _shell2NavigatorKey, routes: [
            GoRoute(
              path: OrdersPage.path,
              name: OrdersPage.name,
              builder: (context, state) => const OrdersPage(),
            )
          ]),
          StatefulShellBranch(initialLocation: ProfilePage.path, navigatorKey: _shell3NavigatorKey, routes: [
            GoRoute(
              path: ProfilePage.path,
              name: ProfilePage.name,
              builder: (context, state) => const ProfilePage(),
            )
          ]),
        ])
  ]);

  static Page<dynamic> _builderPage<T>({required Widget child, required GoRouterState state}) {
    if (Platform.isIOS) {
      return CupertinoPage<T>(child: child, key: state.pageKey);
    } else {
      return MaterialPage<T>(child: child, key: state.pageKey);
    }
  }
}
