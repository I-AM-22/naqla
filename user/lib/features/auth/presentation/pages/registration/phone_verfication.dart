import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:pinput/pinput.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/features/auth/presentation/pages/registration/set_password_page.dart';
import 'package:user/features/auth/presentation/widgets/verification_number.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({super.key});

  static String get name => '/PhoneVerificationPage';

  static String get path => '/PhoneVerificationPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: CustomerAppBar(back: true, appBarParams: AppBarParams()),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 50),
              child: Column(
                children: [
                  30.verticalSpace,
                  AppText.titleMedium(
                    'Phone verification',
                    textAlign: TextAlign.center,
                  ),
                  12.verticalSpace,
                  AppText.bodyRegular(
                    'Enter your OTP code',
                    textAlign: TextAlign.center,
                  ),
                  40.verticalSpace,
                  const VerificationNumber(),
                  20.verticalSpace,
                  Text.rich(
                    textAlign: TextAlign.center,
                    TextSpan(
                      style: context.textTheme.subHeadMedium,
                      children: [
                        TextSpan(
                          text: 'Didn’t receive code? ',
                          style: context.textTheme.subHeadMedium.copyWith(
                              color: context.colorScheme.systemGray.shade700),
                        ),
                        const TextSpan(text: 'Resend again')
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const Spacer(),
            Padding(
              padding: REdgeInsets.symmetric(horizontal: 16),
              child: AppButton.dark(
                onPressed: () => context.pushNamed(SetPasswordPage.name),
                title: 'Verify',
              ),
            ),
            16.verticalSpace
          ],
        ));
  }
}
