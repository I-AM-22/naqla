import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/presentation/widgets/verification_number.dart';

import '../../../../../generated/l10n.dart';
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
            title: S.of(context).verify,
          ),
        ),
        appBar: AppAppBar(back: true, appBarParams: AppBarParams()),
        body: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Padding(
                padding: REdgeInsets.only(left: 50, right: 50, top: 30),
                child: Column(
                  children: [
                    AppText.titleMedium(
                      S.of(context).phone_verification,
                      textAlign: TextAlign.center,
                    ),
                    12.verticalSpace,
                    RichText(
                      text: TextSpan(
                        style: TextStyle(
                            fontFamily: 'noor',
                            color: context.colorScheme.systemGray,
                            fontSize: 16.sp),
                        children: [
                          TextSpan(text: S.of(context).enter_code),
                          TextSpan(text: S.of(context).otp),
                          TextSpan(text: S.of(context).your_code)
                        ],
                      ),
                    ),
                    40.verticalSpace,
                    VerificationNumber(
                      onCompleted: (val) {
                        context.pushNamed(HomePage.name);
                      },
                    ),
                    20.verticalSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        AppText.subHeadMedium(
                            S.of(context).did_not_receive_code,
                            color: context.colorScheme.systemGray.shade700),
                        Flexible(
                          child: TextButton(
                              onPressed: () {},
                              child: AppText.subHeadMedium(
                                S.of(context).resend_again,
                                color: context.colorScheme.primary,
                              )),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ));
  }
}
