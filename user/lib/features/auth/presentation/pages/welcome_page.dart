import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/auth/presentation/pages/register_page.dart';
import 'package:naqla/features/auth/presentation/pages/sign_in_page.dart';
import 'package:naqla/generated/flutter_gen/assets.gen.dart';

import '../../../../generated/l10n.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});
  static const String path = "/WelcomePage";
  static const String name = "WelcomePage";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: AppBar(),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            AppImage.asset(
              Assets.images.svg.welcomeScreen.path,
              height: 276.h,
            ),
            12.verticalSpace,
            AppText.titleMedium(
              S.of(context).Welcome,
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            AppText.bodyRegular(
              S.of(context).have_a_better_sharing_experience,
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            AppButton.dark(
              stretch: true,
              onPressed: () {
                context.pushNamed(RegisterPage.name, extra: true);
              },
              title: S.of(context).create_an_account,
            ),
            10.verticalSpace,
            GestureDetector(
              onTap: () => context.pushNamed(SignInPage.name, extra: true),
              child: Container(
                padding: REdgeInsets.symmetric(vertical: 8),
                decoration: BoxDecoration(border: Border.all(color: context.colorScheme.primary), borderRadius: BorderRadius.circular(8.r)),
                child: Center(
                  child: AppText.subHeadWebMedium(
                    S.of(context).log_in,
                    color: context.colorScheme.primary,
                  ),
                ),
              ),
            ),
            16.verticalSpace
          ],
        ),
      ),
    );
  }
}
