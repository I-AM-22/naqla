import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/features/auth/data/model/driver_model.dart';
import 'package:naqla_driver/features/auth/data/model/wallet_model.dart';
import 'package:naqla_driver/features/auth/presentation/pages/login_page.dart';
import 'package:naqla_driver/features/auth/presentation/state/auth_bloc.dart';
import 'package:naqla_driver/features/cars/presentation/pages/cars_page.dart';
import 'package:naqla_driver/features/chat/presentation/pages/chat_page.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/cars/presentation/pages/add_car_page.dart';
import 'package:naqla_driver/features/home/presentation/pages/home_page.dart';
import 'package:naqla_driver/features/orders/presentation/pages/orders_page.dart';
import 'package:naqla_driver/features/orders/presentation/pages/sub_order_details_page.dart';
import 'package:naqla_driver/features/profile/presentation/pages/profile_page.dart';
import 'package:naqla_driver/features/profile/presentation/pages/verification_phone_number.dart';
import 'package:naqla_driver/features/profile/presentation/pages/wallet_page.dart';

import '../../../features/app/presentation/pages/base_page.dart';
import '../../../features/auth/presentation/pages/phone_verfication.dart';
import '../../../features/auth/presentation/pages/sign_up_page.dart';
import '../../../features/chat/presentation/pages/messages_page.dart';
import '../../../features/home/presentation/pages/order_details_page.dart';
import '../../../features/orders/presentation/pages/image_page.dart';
import '../../../features/profile/presentation/pages/edit_phone_number_page.dart';
import '../../../features/profile/presentation/pages/edit_profile_page.dart';
import '../../../features/profile/presentation/pages/language_page.dart';
import '../../../features/welcome/splash.dart';
import '../../di/di_container.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');

final GlobalKey<NavigatorState> _shell1NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell1');

final GlobalKey<NavigatorState> _shell2NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell2');

final GlobalKey<NavigatorState> _shell3NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell3');

final GlobalKey<NavigatorState> _shell4NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell4');

final GlobalKey<NavigatorState> _shell5NavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'shell5');

class GRouter {
  static final GoRouter router = GoRouter(initialLocation: SplashScreen.path, navigatorKey: _rootNavigatorKey, routes: <RouteBase>[
    GoRoute(
        path: SplashScreen.path,
        name: SplashScreen.name,
        pageBuilder: (BuildContext context, GoRouterState state) {
          return _builderPage(child: const SplashScreen(), state: state);
        }),
    ShellRoute(
        builder: (context, state, child) => BlocProvider(
              create: (context) => getIt<AuthBloc>(),
              child: child,
            ),
        routes: [
          GoRoute(
              path: SignInPage.path,
              name: SignInPage.name,
              pageBuilder: (BuildContext context, GoRouterState state) {
                return _builderPage(child: const SignInPage(), state: state);
              },
              routes: [
                GoRoute(
                  path: PhoneVerificationPage.path,
                  name: PhoneVerificationPage.name,
                  builder: (context, state) => const PhoneVerificationPage(),
                  pageBuilder: (context, state) => CustomTransitionPage(
                    child: const PhoneVerificationPage(),
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
              ]),
        ]),
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
            GoRoute(path: HomePage.path, name: HomePage.name, builder: (context, state) => const HomePage(), routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: OrderDetailsPage.path,
                name: OrderDetailsPage.name,
                builder: (context, state) => OrderDetailsPage(
                  subOrderModel: state.extra as SubOrderModel,
                ),
              ),
            ])
          ]),
          StatefulShellBranch(initialLocation: OrdersPage.path, navigatorKey: _shell2NavigatorKey, routes: [
            GoRoute(path: OrdersPage.path, name: OrdersPage.name, builder: (context, state) => const OrdersPage(), routes: [
              GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: SubOrderDetailsPage.path,
                  name: SubOrderDetailsPage.name,
                  builder: (context, state) => SubOrderDetailsPage(
                        id: state.extra as String,
                      ),
                  routes: [
                    GoRoute(
                      path: ImagePage.path,
                      name: ImagePage.name,
                      parentNavigatorKey: _rootNavigatorKey,
                      builder: (context, state) => ImagePage(
                        imagePath: state.extra as String,
                      ),
                    )
                  ])
            ])
          ]),
          StatefulShellBranch(initialLocation: CarsPage.path, navigatorKey: _shell3NavigatorKey, routes: [
            GoRoute(path: CarsPage.path, name: CarsPage.name, builder: (context, state) => const CarsPage(), routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: AddCarPage.path,
                name: AddCarPage.name,
                builder: (context, state) => AddCarPage(
                  param: state.extra as AddCaraParam,
                ),
              ),
            ])
          ]),
          StatefulShellBranch(initialLocation: ChatPage.path, navigatorKey: _shell4NavigatorKey, routes: [
            GoRoute(path: ChatPage.path, name: ChatPage.name, builder: (context, state) => const ChatPage(), routes: [
              GoRoute(
                path: MessagesPage.path,
                name: MessagesPage.name,
                parentNavigatorKey: _rootNavigatorKey,
                builder: (context, state) => MessagesPage(
                  param: state.extra as MessageParam,
                ),
              )
            ])
          ]),
          StatefulShellBranch(initialLocation: ProfilePage.path, navigatorKey: _shell5NavigatorKey, routes: [
            GoRoute(path: ProfilePage.path, name: ProfilePage.name, builder: (context, state) => const ProfilePage(), routes: [
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: EditProfilePage.path,
                name: EditProfilePage.name,
                builder: (context, state) => EditProfilePage(driverModel: state.extra as DriverModel),
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: EditProfilePage(driverModel: state.extra as DriverModel),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                    child: child,
                  ),
                ),
              ),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: WalletPage.path,
                name: WalletPage.name,
                builder: (context, state) => WalletPage(walletModel: state.extra as WalletModel),
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: WalletPage(walletModel: state.extra as WalletModel),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                    child: child,
                  ),
                ),
              ),
              GoRoute(
                  parentNavigatorKey: _rootNavigatorKey,
                  path: EditPhoneNumberPage.path,
                  name: EditPhoneNumberPage.name,
                  builder: (context, state) => EditPhoneNumberPage(phone: state.extra as String),
                  pageBuilder: (context, state) => CustomTransitionPage(
                        child: EditPhoneNumberPage(phone: state.extra as String),
                        transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                          position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                          child: child,
                        ),
                      ),
                  routes: [
                    GoRoute(
                      parentNavigatorKey: _rootNavigatorKey,
                      path: VerificationUpdatePhoneNumber.path,
                      name: VerificationUpdatePhoneNumber.name,
                      builder: (context, state) => const VerificationUpdatePhoneNumber(),
                    ),
                  ]),
              GoRoute(
                parentNavigatorKey: _rootNavigatorKey,
                path: LanguagePage.path,
                name: LanguagePage.name,
                builder: (context, state) => const LanguagePage(),
                pageBuilder: (context, state) => CustomTransitionPage(
                  child: const LanguagePage(),
                  transitionsBuilder: (context, animation, secondaryAnimation, child) => SlideTransition(
                    position: Tween<Offset>(begin: const Offset(1, 0), end: Offset.zero).animate(animation),
                    child: child,
                  ),
                ),
              ),
            ])
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
