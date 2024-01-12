import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/auth/presentation/pages/registration/register_page.dart';
import 'package:user/features/auth/presentation/pages/sign_in_page.dart';
import 'package:user/generated/flutter_gen/assets.gen.dart';
import 'package:user/generated/locale_keys.g.dart';

class WelcomePage extends StatelessWidget {
  const WelcomePage({super.key});

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
              LocaleKeys.welcome_Welcome.tr(),
              textAlign: TextAlign.center,
            ),
            12.verticalSpace,
            AppText.bodyRegular(
              LocaleKeys.welcome_have_a_better_sharing_experience.tr(),
              textAlign: TextAlign.center,
            ),
            const Spacer(),
            AppButton.dark(
              stretch: true,
              onPressed: () {
                context.pushNamed(RegisterPage.name);
              },
              title: LocaleKeys.signUp_CreateAccount.tr(),
            ),
            10.verticalSpace,
            Container(
              decoration: BoxDecoration(
                  border: Border.all(color: context.colorScheme.primary),
                  borderRadius: BorderRadius.circular(8.r)),
              child: Center(
                child: AppButton.ghost(
                  onPressed: () => context.pushNamed(SignInPage.name),
                  title: LocaleKeys.signUp_login.tr(),
                ),
              ),
            ),
            10.verticalSpace
          ],
        ),
      ),
    );
  }
}
