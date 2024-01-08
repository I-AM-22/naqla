import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/features/auth/presentation/pages/set_new_password_page.dart';
import 'package:user/features/auth/presentation/widgets/verification_number.dart';

class ForgotPasswordSmsPage extends StatelessWidget {
  const ForgotPasswordSmsPage({super.key});
  static String get path => '/ForgotPasswordSmsPage';
  static String get name => '/ForgotPasswordSmsPage';

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
                'Code has been send to ***** ***70',
                textAlign: TextAlign.center,
              ),
              40.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 30),
                child: const VerificationNumber(),
              ),
              20.verticalSpace,
              Text.rich(
                  textAlign: TextAlign.center,
                  style: context.textTheme.subHeadMedium,
                  TextSpan(children: [
                    TextSpan(
                        text: 'Didn’t receive code? ',
                        style: context.textTheme.subHeadMedium.copyWith(
                            color: context.colorScheme.systemGray.shade700)),
                    TextSpan(text: 'Resend again')
                  ])),
              const Spacer(),
              AppButton.dark(
                onPressed: () => context.pushNamed(SetNewPasswordPage.name),
                title: 'Verify',
                stretch: true,
              ),
              16.verticalSpace
            ],
          ),
        ));
  }
}
