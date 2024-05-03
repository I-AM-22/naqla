// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

abstract class _$AppRouter extends RootStackRouter {
  // ignore: unused_element
  _$AppRouter({super.navigatorKey});

  @override
  final Map<String, PageFactory> pagesMap = {
    AboutUsRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const AboutUsPage(),
      );
    },
    CreateOrderRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const CreateOrderPage(),
      );
    },
    DeleteAccountRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const DeleteAccountPage(),
      );
    },
    EditPhoneNumberRoute.name: (routeData) {
      final args = routeData.argsAs<EditPhoneNumberRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditPhoneNumberPage(
          key: args.key,
          param: args.param,
        ),
      );
    },
    EditProfileRoute.name: (routeData) {
      final args = routeData.argsAs<EditProfileRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: EditProfilePage(
          key: args.key,
          param: args.param,
        ),
      );
    },
    HelpAndSupportRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const HelpAndSupportPage(),
      );
    },
    HomeRoute.name: (routeData) {
      final args = routeData.argsAs<HomeRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: HomePage(
          key: args.key,
          comeFromSplash: args.comeFromSplash,
        ),
      );
    },
    LanguageRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const LanguagePage(),
      );
    },
    OrderPhotosRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const OrderPhotosPage(),
      );
    },
    PhoneVerificationRoute.name: (routeData) {
      final args = routeData.argsAs<PhoneVerificationRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: PhoneVerificationPage(
          key: args.key,
          param: args.param,
        ),
      );
    },
    ProfileRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const ProfilePage(),
      );
    },
    RegisterRoute.name: (routeData) {
      final args = routeData.argsAs<RegisterRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: RegisterPage(
          key: args.key,
          showTextButton: args.showTextButton,
        ),
      );
    },
    SignInRoute.name: (routeData) {
      final args = routeData.argsAs<SignInRouteArgs>();
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: SignInPage(
          key: args.key,
          showTextButton: args.showTextButton,
        ),
      );
    },
    WelcomeRoute.name: (routeData) {
      return AutoRoutePage<dynamic>(
        routeData: routeData,
        child: const WelcomePage(),
      );
    },
  };
}

/// generated route for
/// [AboutUsPage]
class AboutUsRoute extends PageRouteInfo<void> {
  const AboutUsRoute({List<PageRouteInfo>? children})
      : super(
          AboutUsRoute.name,
          initialChildren: children,
        );

  static const String name = 'AboutUsRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [CreateOrderPage]
class CreateOrderRoute extends PageRouteInfo<void> {
  const CreateOrderRoute({List<PageRouteInfo>? children})
      : super(
          CreateOrderRoute.name,
          initialChildren: children,
        );

  static const String name = 'CreateOrderRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [DeleteAccountPage]
class DeleteAccountRoute extends PageRouteInfo<void> {
  const DeleteAccountRoute({List<PageRouteInfo>? children})
      : super(
          DeleteAccountRoute.name,
          initialChildren: children,
        );

  static const String name = 'DeleteAccountRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [EditPhoneNumberPage]
class EditPhoneNumberRoute extends PageRouteInfo<EditPhoneNumberRouteArgs> {
  EditPhoneNumberRoute({
    Key? key,
    required EditPhoneParam param,
    List<PageRouteInfo>? children,
  }) : super(
          EditPhoneNumberRoute.name,
          args: EditPhoneNumberRouteArgs(
            key: key,
            param: param,
          ),
          initialChildren: children,
        );

  static const String name = 'EditPhoneNumberRoute';

  static const PageInfo<EditPhoneNumberRouteArgs> page =
      PageInfo<EditPhoneNumberRouteArgs>(name);
}

class EditPhoneNumberRouteArgs {
  const EditPhoneNumberRouteArgs({
    this.key,
    required this.param,
  });

  final Key? key;

  final EditPhoneParam param;

  @override
  String toString() {
    return 'EditPhoneNumberRouteArgs{key: $key, param: $param}';
  }
}

/// generated route for
/// [EditProfilePage]
class EditProfileRoute extends PageRouteInfo<EditProfileRouteArgs> {
  EditProfileRoute({
    Key? key,
    required EditProfileParam param,
    List<PageRouteInfo>? children,
  }) : super(
          EditProfileRoute.name,
          args: EditProfileRouteArgs(
            key: key,
            param: param,
          ),
          initialChildren: children,
        );

  static const String name = 'EditProfileRoute';

  static const PageInfo<EditProfileRouteArgs> page =
      PageInfo<EditProfileRouteArgs>(name);
}

class EditProfileRouteArgs {
  const EditProfileRouteArgs({
    this.key,
    required this.param,
  });

  final Key? key;

  final EditProfileParam param;

  @override
  String toString() {
    return 'EditProfileRouteArgs{key: $key, param: $param}';
  }
}

/// generated route for
/// [HelpAndSupportPage]
class HelpAndSupportRoute extends PageRouteInfo<void> {
  const HelpAndSupportRoute({List<PageRouteInfo>? children})
      : super(
          HelpAndSupportRoute.name,
          initialChildren: children,
        );

  static const String name = 'HelpAndSupportRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [HomePage]
class HomeRoute extends PageRouteInfo<HomeRouteArgs> {
  HomeRoute({
    Key? key,
    required bool comeFromSplash,
    List<PageRouteInfo>? children,
  }) : super(
          HomeRoute.name,
          args: HomeRouteArgs(
            key: key,
            comeFromSplash: comeFromSplash,
          ),
          initialChildren: children,
        );

  static const String name = 'HomeRoute';

  static const PageInfo<HomeRouteArgs> page = PageInfo<HomeRouteArgs>(name);
}

class HomeRouteArgs {
  const HomeRouteArgs({
    this.key,
    required this.comeFromSplash,
  });

  final Key? key;

  final bool comeFromSplash;

  @override
  String toString() {
    return 'HomeRouteArgs{key: $key, comeFromSplash: $comeFromSplash}';
  }
}

/// generated route for
/// [LanguagePage]
class LanguageRoute extends PageRouteInfo<void> {
  const LanguageRoute({List<PageRouteInfo>? children})
      : super(
          LanguageRoute.name,
          initialChildren: children,
        );

  static const String name = 'LanguageRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [OrderPhotosPage]
class OrderPhotosRoute extends PageRouteInfo<void> {
  const OrderPhotosRoute({List<PageRouteInfo>? children})
      : super(
          OrderPhotosRoute.name,
          initialChildren: children,
        );

  static const String name = 'OrderPhotosRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [PhoneVerificationPage]
class PhoneVerificationRoute extends PageRouteInfo<PhoneVerificationRouteArgs> {
  PhoneVerificationRoute({
    Key? key,
    required PhoneVerificationParam param,
    List<PageRouteInfo>? children,
  }) : super(
          PhoneVerificationRoute.name,
          args: PhoneVerificationRouteArgs(
            key: key,
            param: param,
          ),
          initialChildren: children,
        );

  static const String name = 'PhoneVerificationRoute';

  static const PageInfo<PhoneVerificationRouteArgs> page =
      PageInfo<PhoneVerificationRouteArgs>(name);
}

class PhoneVerificationRouteArgs {
  const PhoneVerificationRouteArgs({
    this.key,
    required this.param,
  });

  final Key? key;

  final PhoneVerificationParam param;

  @override
  String toString() {
    return 'PhoneVerificationRouteArgs{key: $key, param: $param}';
  }
}

/// generated route for
/// [ProfilePage]
class ProfileRoute extends PageRouteInfo<void> {
  const ProfileRoute({List<PageRouteInfo>? children})
      : super(
          ProfileRoute.name,
          initialChildren: children,
        );

  static const String name = 'ProfileRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}

/// generated route for
/// [RegisterPage]
class RegisterRoute extends PageRouteInfo<RegisterRouteArgs> {
  RegisterRoute({
    Key? key,
    required bool showTextButton,
    List<PageRouteInfo>? children,
  }) : super(
          RegisterRoute.name,
          args: RegisterRouteArgs(
            key: key,
            showTextButton: showTextButton,
          ),
          initialChildren: children,
        );

  static const String name = 'RegisterRoute';

  static const PageInfo<RegisterRouteArgs> page =
      PageInfo<RegisterRouteArgs>(name);
}

class RegisterRouteArgs {
  const RegisterRouteArgs({
    this.key,
    required this.showTextButton,
  });

  final Key? key;

  final bool showTextButton;

  @override
  String toString() {
    return 'RegisterRouteArgs{key: $key, showTextButton: $showTextButton}';
  }
}

/// generated route for
/// [SignInPage]
class SignInRoute extends PageRouteInfo<SignInRouteArgs> {
  SignInRoute({
    Key? key,
    required bool showTextButton,
    List<PageRouteInfo>? children,
  }) : super(
          SignInRoute.name,
          args: SignInRouteArgs(
            key: key,
            showTextButton: showTextButton,
          ),
          initialChildren: children,
        );

  static const String name = 'SignInRoute';

  static const PageInfo<SignInRouteArgs> page = PageInfo<SignInRouteArgs>(name);
}

class SignInRouteArgs {
  const SignInRouteArgs({
    this.key,
    required this.showTextButton,
  });

  final Key? key;

  final bool showTextButton;

  @override
  String toString() {
    return 'SignInRouteArgs{key: $key, showTextButton: $showTextButton}';
  }
}

/// generated route for
/// [WelcomePage]
class WelcomeRoute extends PageRouteInfo<void> {
  const WelcomeRoute({List<PageRouteInfo>? children})
      : super(
          WelcomeRoute.name,
          initialChildren: children,
        );

  static const String name = 'WelcomeRoute';

  static const PageInfo<void> page = PageInfo<void>(name);
}
