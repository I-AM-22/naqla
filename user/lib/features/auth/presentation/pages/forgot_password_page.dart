import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import 'forgot_password_sms_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  static String get path => '/ForgotPasswordPage';
  static String get name => '/ForgotPasswordPage';
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: CustomerAppBar(
          back: true,
          appBarParams: AppBarParams(),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: kpPaddingPage),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              30.verticalSpace,
              AppText.titleMedium(
                'Forgot Password',
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              AppText.bodyRegular(
                'Select which contact details should we use to reset your password',
                textAlign: TextAlign.center,
              ),
              36.verticalSpace,
              InkWell(
                onTap: () => context.pushNamed(ForgotPasswordSmsPage.name),
                child: Container(
                  height: 80.h,
                  padding: REdgeInsets.all(16),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: context.colorScheme.baseColor,
                    ),
                    color: const Color(0xFFFFFBE7),
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Row(
                    children: [
                      Container(
                        width: 50.r,
                        height: 50.r,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: Colors.white,
                          border:
                              Border.all(color: context.colorScheme.baseColor),
                        ),
                        child: AppImage.asset(
                            Assets.icons.essential.messageSvgrepoCom.path),
                      ),
                      8.horizontalSpace,
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          AppText.subHeadWebMedium(
                            'Via SMS',
                            color: context.colorScheme.systemGray.shade300,
                          ),
                          AppText.subHeadWebMedium('***** ***70')
                        ],
                      )
                    ],
                  ),
                ),
              ),
              16.verticalSpace,
              Container(
                height: 80.h,
                padding: REdgeInsets.all(16),
                decoration: BoxDecoration(
                  border: Border.all(
                    color: Color(0xFFE5E5E5),
                  ),
                  color: Color(0xFFFAFAFA).withOpacity(.5),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Row(
                  children: [
                    Container(
                      width: 50.r,
                      height: 50.r,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: Colors.white,
                        border:
                            Border.all(color: context.colorScheme.baseColor),
                      ),
                      child: AppImage.asset(
                          Assets.icons.essential.messageSvgrepoCom.path),
                    ),
                    8.horizontalSpace,
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        AppText.subHeadWebMedium(
                          'Via Email',
                          color: context.colorScheme.systemGray.shade300,
                        ),
                        AppText.subHeadWebMedium('**** **** **** xyz@xyz.com')
                      ],
                    )
                  ],
                ),
              ),
              const Spacer(),
              AppButton.dark(
                title: 'Continue',
                stretch: true,
              ),
              16.verticalSpace
            ],
          ),
        ));
  }
}
