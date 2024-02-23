import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/config/themes/utils.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/generated/l10n.dart';

import 'forgot_password_sms_page.dart';

class ForgotPasswordPage extends StatelessWidget {
  const ForgotPasswordPage({super.key});
  static String get path => '/ForgotPasswordPage';
  static String get name => '/ForgotPasswordPage';
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottomNavigationBar: Padding(
          padding:
              REdgeInsets.symmetric(horizontal: kpPaddingPage, vertical: 10),
          child: AppButton.dark(
            onPressed: () => context.pushNamed(ForgotPasswordSmsPage.name),
            title: 'continue',
            stretch: true,
          ),
        ),
        appBar: AppAppBar(
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
                S.of(context).forget_password,
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              AppText.bodyRegular(
                'LocaleKeys.signUp_we_will_send_a_code.tr()',
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              AppText.bodyRegular(
                '099*******',
                textAlign: TextAlign.center,
              ),
              16.verticalSpace
            ],
          ),
        ));
  }
}
