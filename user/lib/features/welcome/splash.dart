import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/home/presentation/pages/home_page.dart';
import 'package:naqla/features/on_boarding/presentation/pages/on_boarding_screen.dart';

import '../../generated/flutter_gen/assets.gen.dart';

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
      if (GetIt.I<PrefsRepository>().registeredUser) {
        context.goNamed(HomePage.name, extra: false);
      } else {
        context.goNamed(OnBoardingScreen.name);
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
            CircleAvatar(backgroundColor: context.colorScheme.primary, radius: 50.r, backgroundImage: AssetImage(Assets.images.jpg.logo.path)),
            const Spacer(),
            AppText.subHeadMedium(
              "Naqla",
            ),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }
}
