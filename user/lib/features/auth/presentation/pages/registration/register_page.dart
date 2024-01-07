import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text.dart';
import 'package:user/core/global_widgets/app_text_field.dart';
import 'package:user/core/global_widgets/word_divider.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/features/auth/presentation/pages/registration/phone_verfication.dart';
import 'package:user/features/auth/presentation/widgets/custom_social.dart';
import 'package:user/generated/flutter_gen/assets.gen.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String get name => '/RegisterPage';
  static String get path => '/RegisterPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomerAppBar(back: true, appBarParams: AppBarParams()),
        body: Container(
          padding: REdgeInsets.symmetric(horizontal: kpPaddingPage),
          height: context.bodyHeight,
          child: ListView(
            children: [
              12.verticalSpace,
              AppText.titleMedium(
                'Sign Up',
              ),
              20.verticalSpace,
              AppTextFormField(
                hintText: 'Name',
              ),
              20.verticalSpace,
              AppTextFormField(
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
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppImage.asset(
                    Assets.icons.essential.checkCircle.path,
                    color: context.colorScheme.success,
                    size: 24.r,
                  ),
                  Expanded(
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
              AppButton.dark(
                onPressed: () => context.pushNamed(PhoneVerificationPage.name),
                stretch: true,
                title: 'Sign Up',
                fixedSize: Size.fromHeight(48.h),
              ),
              20.verticalSpace,
              const WordDivider(),
              15.verticalSpace,
              const CustomSocial(),
              40.verticalSpace,
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
                    const TextSpan(text: 'Sign in'),
                  ],
                ),
              ),
              20.verticalSpace
            ],
          ),
        ));
  }
}
