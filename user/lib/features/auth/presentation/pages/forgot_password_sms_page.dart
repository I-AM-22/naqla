import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/config/themes/utils.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/presentation/pages/set_new_password_page.dart';
import 'package:naqla/features/auth/presentation/widgets/verification_number.dart';

class ForgotPasswordSmsPage extends StatelessWidget {
  const ForgotPasswordSmsPage({super.key});
  static String get path => '/ForgotPasswordSmsPage';
  static String get name => '/ForgotPasswordSmsPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottomNavigationBar: Padding(
          padding:
              REdgeInsets.symmetric(horizontal: kpPaddingPage, vertical: 10),
          child: AppButton.dark(
            onPressed: () => context.pushNamed(SetNewPasswordPage.name),
            title: 'LocaleKeys.signUp_Verify.tr()',
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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
              Center(
                child: AppText.titleMedium(
                  'LocaleKeys.signUp_ForgetPassword.tr()',
                  textAlign: TextAlign.center,
                ),
              ),
              12.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.bodyRegular(
                    '{LocaleKeys.signUp_Code_has_been_send_to.tr()} ',
                    textAlign: TextAlign.center,
                  ),
                  AppText.bodyRegular(
                    '099*******',
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
              40.verticalSpace,
              Padding(
                padding: REdgeInsets.symmetric(horizontal: 30),
                child: const VerificationNumber(),
              ),
              20.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.bodyMedium(
                      'LocaleKeys.signUp_Did_not_receive_code.tr()',
                      color: context.colorScheme.systemGray.shade700),
                  TextButton(
                      onPressed: () {},
                      child: AppText.bodyMedium(
                        'LocaleKeys.signUp_Resend_again.tr()',
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
