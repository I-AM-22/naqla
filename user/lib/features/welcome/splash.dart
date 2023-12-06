import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/router/router.dart';
import 'package:user/core/util/extensions/build_context.dart';
import 'package:user/features/app/domain/repository/prefs_repository.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/app_svg_picture.dart';
import 'package:user/features/app/presentation/widgets/app_text_view.dart';
import 'package:user/generated/assets.dart';

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
        context.goNamed(GRouter.config.authRoutes.login);
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
            // const Spacer(),
            // const AppSvgPicture(
            //   Assets.logo,
            //   width: 100,
            // ),
            const Spacer(),
            AppTextView("Driver",
                style: context.textTheme.titleMedium!
                    .copyWith(color: context.colorScheme.primary)),
            25.verticalSpace,
          ],
        ),
      ),
    );
  }
}
