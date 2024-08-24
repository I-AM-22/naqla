import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/auth/presentation/pages/login_page.dart';
import 'package:naqla_driver/features/home/presentation/pages/home_page.dart';

import '../../generated/flutter_gen/assets.gen.dart';
import '../app/domain/repository/prefs_repository.dart';
import '../app/presentation/widgets/app_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  static const String path = "/SplashScreen";
  static const String name = "/SplashScreen";

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (getIt<PrefsRepository>().registeredUser) {
        context.goNamed(HomePage.name);
      } else {
        context.goNamed(SignInPage.name);
      }
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            Container(
              width: 100.w,
              height: 100.w,
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(shape: BoxShape.circle, color: context.colorScheme.primary),
              child: AppImage.asset(
                Assets.images.jpg.logo.path,
                fit: BoxFit.cover,
              ),
            ),
            const Spacer(),
            AppText.subHeadMedium(
              "Naqla Driver",
            ),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }
}
