import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/features/app/presentation/pages/base_page.dart';
import 'package:naqla/features/auth/data/model/auth_model.dart';

import '../../../features/auth/presentation/pages/phone_verfication.dart';
import '../../../features/auth/presentation/pages/register_page.dart';
import '../../../features/auth/presentation/pages/set_location_page.dart';
import '../../../features/auth/presentation/pages/sign_in_page.dart';
import '../../../features/auth/presentation/pages/welcome_page.dart';
import '../../../features/home/presentation/pages/home_page.dart';
import '../../../features/on_boarding/presentation/pages/on_boarding_screen.dart';
import '../../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../../features/profile/presentation/pages/profile_page.dart';
import '../../../features/welcome/splash.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shell1NavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell1');

final GlobalKey<NavigatorState> _shell2NavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell2');

final GlobalKey<NavigatorState> _shell3NavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell3');

final GlobalKey<NavigatorState> _shell4NavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell4');

final GlobalKey<NavigatorState> _shell5NavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'shell5');

class GRouter {
  static GoRouter get router => _router;

  static final GoRouter _router = GoRouter(
      initialLocation: SplashScreen.path,
      navigatorKey: _rootNavigatorKey,
      routes: <RouteBase>[
        GoRoute(
            path: SplashScreen.path,
            name: SplashScreen.name,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _builderPage(child: const SplashScreen(), state: state);
            }),
        GoRoute(
            path: OnBoardingScreen.path,
            name: OnBoardingScreen.name,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _builderPage(
                  child: const OnBoardingScreen(), state: state);
            }),
        GoRoute(
            path: SetLocationPage.path,
            name: SetLocationPage.name,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _builderPage(child: const SetLocationPage(), state: state);
            }),
        GoRoute(
            path: WelcomePage.path,
            name: WelcomePage.name,
            pageBuilder: (BuildContext context, GoRouterState state) {
              return _builderPage(child: const WelcomePage(), state: state);
            }),
        GoRoute(
          path: RegisterPage.path,
          name: RegisterPage.name,
          builder: (context, state) =>
              RegisterPage(showTextButton: state.extra as bool),
        ),
        GoRoute(
          path: PhoneVerificationPage.path,
          name: PhoneVerificationPage.name,
          builder: (context, state) =>
              PhoneVerificationPage(phone: state.extra as String),
        ),
        GoRoute(
          path: SignInPage.path,
          name: SignInPage.name,
          builder: (context, state) =>
              SignInPage(showTextButton: state.extra as bool),
        ),
        StatefulShellRoute.indexedStack(
          builder: (context, state, child) {
            var fullPath =
                GoRouter.of(context).routeInformationProvider.value.uri.path;
            return BasePage(
              fullPath: fullPath,
              child: child,
            );
          },
          branches: [
            StatefulShellBranch(
                initialLocation: HomePage.path,
                navigatorKey: _shell1NavigatorKey,
                routes: [
                  GoRoute(
                    parentNavigatorKey: _shell1NavigatorKey,
                    path: HomePage.path,
                    name: HomePage.name,
                    builder: (context, state) => const HomePage(),
                  ),
                ]),
            StatefulShellBranch(
                initialLocation: ProfilePage.path,
                navigatorKey: _shell4NavigatorKey,
                routes: [
                  GoRoute(
                      parentNavigatorKey: _shell4NavigatorKey,
                      path: ProfilePage.path,
                      name: ProfilePage.name,
                      builder: (context, state) => const ProfilePage(),
                      routes: [
                        GoRoute(
                          parentNavigatorKey: _rootNavigatorKey,
                          path: EditProfilePage.path,
                          name: EditProfilePage.name,
                          builder: (context, state) =>
                              EditProfilePage(user: state.extra as User),
                        ),
                      ]),
                ]),
          ],
        )
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
