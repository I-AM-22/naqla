import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/auth/presentation/pages/sign_up_page.dart';

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
      if (GetIt.I<PrefsRepository>().registeredUser) {
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
            CircleAvatar(backgroundColor: context.colorScheme.primary, radius: 50.r, backgroundImage: AssetImage('')),
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
