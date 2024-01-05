import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:user/core/core.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';

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
                  Pinput(
                    length: 5,
                    obscureText: false,
                    obscuringWidget: Container(
                      width: 50.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: context.colorScheme.primary,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: context.colorScheme.systemGray.shade200,
                            width: 2),
                      ),
                    ),
                    defaultPinTheme: const PinTheme(),
                    animationCurve: Curves.easeInOut,
                    animationDuration: const Duration(milliseconds: 300),
                    submittedPinTheme: PinTheme(
                      constraints:
                          BoxConstraints(minHeight: 48.h, minWidth: 50.w),
                      textStyle: context.textTheme.headlineLarge?.copyWith(
                          color: context.colorScheme.primary,
                          fontWeight: FontWeight.w500),
                      decoration: BoxDecoration(
                        border: Border.all(color: context.colorScheme.primary),
                        borderRadius: BorderRadius.circular(8),
                        color: context.colorScheme.primary.withOpacity(.1),
                      ),
                    ),
                    preFilledWidget: Container(
                      width: 50.w,
                      height: 48.h,
                      decoration: BoxDecoration(
                        color: context.colorScheme.onPrimary,
                        borderRadius: BorderRadius.circular(7),
                        border: Border.all(
                            color: context.colorScheme.systemGray.shade200,
                            width: 1),
                      ),
                    ),
                  ),
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
                onPressed: () {},
                title: 'Verify',
              ),
            ),
            16.verticalSpace
          ],
        ));
  }
}
