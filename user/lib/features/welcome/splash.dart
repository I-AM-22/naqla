import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/config/router/router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/domain/repository/prefs_repository.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (GetIt.I<PrefsRepository>().registeredUser) {
        //final user = GetIt.I<PrefsRepository>().user!;
        context.goNamed(GRouter.config.homeScreen.homeScreen);
      } else {
        context.goNamed(GRouter.config.onBoardingRoutes.onBoarding);
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
