import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text.dart';
import 'package:user/core/global_widgets/app_text_field.dart';
import 'package:user/core/global_widgets/word_divider.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/generated/flutter_gen/assets.gen.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String get name => '/RegisterPage';
  static String get path => '/RegisterPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: CustomerAppBar(back: true, appBarParams: AppBarParams()),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: kpPaddingPage),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              12.verticalSpace,
              AppText.titleMedium(
                'Sign Up',
              ),
              20.verticalSpace,
              const AppTextFormField(
                hintText: 'Name',
              ),
              20.verticalSpace,
              const AppTextFormField(
                hintText: 'Email',
              ),
              20.verticalSpace,
              AppTextFormField(
                hintText: '+880 Your mobile number',
                suffixIcon: Padding(
                  padding: REdgeInsets.all(12.0),
                  child: AppImage.asset(Assets.icons.arrow.downArrow.path),
                ),
              ),
              20.verticalSpace,
              AppTextFormField(
                hintText: 'Gender',
                suffixIcon: Padding(
                  padding: REdgeInsets.all(12.0),
                  child: AppImage.asset(
                    Assets.icons.arrow.downArrow.path,
                  ),
                ),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppImage.asset(
                    Assets.icons.essential.map.path,
                    color: context.colorScheme.success,
                    size: 24.r,
                  ),
                  Flexible(
                    child: RichText(
                        text: TextSpan(
                            style: context.textTheme.bodyMedium,
                            children: [
                          TextSpan(
                            text: 'By signing up. you agree to the ',
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: context.colorScheme.systemGray.shade300),
                          ),
                          const TextSpan(text: 'Terms of service'),
                          TextSpan(
                            text: ' and ',
                            style: context.textTheme.bodyMedium!.copyWith(
                                color: context.colorScheme.systemGray.shade300),
                          ),
                          const TextSpan(text: 'Privacy policy.')
                        ])),
                  ),
                ],
              ),
              20.verticalSpace,
              const AppButton.dark(
                stretch: true,
                title: 'Sign Up',
              ),
              20.verticalSpace,
              WordDivider(),
              15.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppButton.ghost(
                      textStyle: context.textTheme.subHeadWebMedium
                          .copyWith(color: context.colorScheme.primary),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              color: context.colorScheme.systemGray.shade200,
                              width: 1)),
                      fixedSize: Size.fromHeight(48.h),
                      child: Center(
                          child: AppImage.asset('assets/icons/social/Gmail.svg',
                              height: 24.w, width: 24.w)),
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: AppButton.ghost(
                      textStyle: context.textTheme.subHeadWebMedium
                          .copyWith(color: context.colorScheme.primary),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              color: context.colorScheme.systemGray.shade200,
                              width: 1)),
                      fixedSize: Size.fromHeight(48.h),
                      child: Center(
                          child: AppImage.asset(
                              'assets/icons/social/facebook.svg',
                              height: 40.w,
                              width: 24.w)),
                    ),
                  ),
                  16.horizontalSpace,
                  Expanded(
                    child: AppButton.ghost(
                      textStyle: context.textTheme.subHeadWebMedium
                          .copyWith(color: context.colorScheme.primary),
                      onPressed: () {},
                      style: ElevatedButton.styleFrom(
                          side: BorderSide(
                              color: context.colorScheme.systemGray.shade200,
                              width: 1)),
                      fixedSize: Size.fromHeight(48.h),
                      child: Center(
                          child: AppImage.asset('assets/icons/social/apple.svg',
                              height: 40.w, width: 40.w)),
                    ),
                  ),
                ],
              ),
              Spacer(),
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  style: context.textTheme.bodyMedium,
                  children: [
                    TextSpan(
                      text: 'Already have an account? ',
                      style: context.textTheme.bodyMedium!.copyWith(
                          color: context.colorScheme.systemGray.shade700),
                    ),
                    TextSpan(text: 'Sign in'),
                  ],
                ),
              ),
              Spacer()
            ],
          ),
        ));
  }
}
