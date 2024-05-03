import 'package:auto_route/auto_route.dart';
import 'package:flutter/material.dart';
import 'package:naqla/features/auth/presentation/pages/phone_verfication.dart';
import 'package:naqla/features/auth/presentation/pages/register_page.dart';
import 'package:naqla/features/auth/presentation/pages/sign_in_page.dart';
import 'package:naqla/features/auth/presentation/pages/welcome_page.dart';
import 'package:naqla/features/home/presentation/pages/create_order.dart';
import 'package:naqla/features/home/presentation/pages/home_page.dart';
import 'package:naqla/features/home/presentation/pages/order_photos_page.dart';
import 'package:naqla/features/profile/presentation/pages/about_us_page.dart';
import 'package:naqla/features/profile/presentation/pages/delete_account_page.dart';
import 'package:naqla/features/profile/presentation/pages/edit_phone_number_page.dart';
import 'package:naqla/features/profile/presentation/pages/edit_profile_page.dart';
import 'package:naqla/features/profile/presentation/pages/help_and_support_page.dart';
import 'package:naqla/features/profile/presentation/pages/language_page.dart';
import 'package:naqla/features/profile/presentation/pages/profile_page.dart';

part 'app_router.gr.dart';

@AutoRouterConfig(replaceInRouteName: 'Page,Route')
class AppRouter extends _$AppRouter {
  @override
  List<AutoRoute> get routes => [
        /// routes go here
        AutoRoute(page: RegisterRoute.page, path: RegisterPage.path),
        AutoRoute(
            page: PhoneVerificationRoute.page,
            path: PhoneVerificationPage.path),
        AutoRoute(page: SignInRoute.page, path: SignInPage.path),
        AutoRoute(page: WelcomeRoute.page, path: WelcomePage.path),
        AutoRoute(page: HomeRoute.page, path: HomePage.path),
        AutoRoute(page: CreateOrderRoute.page, path: CreateOrderPage.path),
        AutoRoute(page: OrderPhotosRoute.page, path: OrderPhotosPage.path),
        AutoRoute(page: LanguageRoute.page, path: LanguagePage.path),
        AutoRoute(page: ProfileRoute.page, path: ProfilePage.path),
        AutoRoute(page: EditPhoneNumberRoute.page, path: EditPhoneNumberPage.path),
        AutoRoute(page: EditProfileRoute.page, path: EditProfilePage.path),
        AutoRoute(page: AboutUsRoute.page, path: AboutUsPage.path),
        AutoRoute(page: DeleteAccountRoute.page, path: DeleteAccountPage.path),
        AutoRoute(page: HelpAndSupportRoute.page, path: HelpAndSupportPage.path),
      ];
}
