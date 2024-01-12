import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/presentation/widgets/verification_number.dart';
import 'package:naqla/generated/locale_keys.g.dart';

import '../../../../home/presentation/pages/home_page.dart';

class PhoneVerificationPage extends StatelessWidget {
  const PhoneVerificationPage({super.key});

  static String get name => '/PhoneVerificationPage';

  static String get path => '/PhoneVerificationPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottomNavigationBar: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16, vertical: 10),
          child: AppButton.dark(
            onPressed: () => context.pushNamed(HomePage.name),
            title: LocaleKeys.signUp_Verify.tr(),
          ),
        ),
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
                    LocaleKeys.signUp_phone_verification.tr(),
                    textAlign: TextAlign.center,
                  ),
                  12.verticalSpace,
                  AppText.bodyRegular(
                    LocaleKeys.signUp_Enter_your_OTP_code.tr(),
                    textAlign: TextAlign.center,
                  ),
                  40.verticalSpace,
                  const VerificationNumber(),
                  20.verticalSpace,
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      AppText.subHeadMedium(
                          LocaleKeys.signUp_Did_not_receive_code.tr(),
                          color: context.colorScheme.systemGray.shade700),
                      TextButton(
                          onPressed: () {},
                          child: AppText.subHeadMedium(
                            LocaleKeys.signUp_Resend_again.tr(),
                            color: context.colorScheme.primary,
                          ))
                    ],
                  ),
                ],
              ),
            ),
          ],
        ));
  }
}
