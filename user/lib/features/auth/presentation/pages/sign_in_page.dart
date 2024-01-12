import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/config/themes/utils.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/global_widgets/app_text_field.dart';
import 'package:naqla/core/global_widgets/word_divider.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:naqla/features/auth/presentation/pages/registration/phone_verfication.dart';
import 'package:naqla/features/auth/presentation/pages/registration/register_page.dart';
import 'package:naqla/features/auth/presentation/widgets/custom_social.dart';
import 'package:naqla/generated/locale_keys.g.dart';

class SignInPage extends StatelessWidget {
  const SignInPage({super.key});
  static String get path => '/SignInPage';
  static String get name => '/SignInPage';

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
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              30.verticalSpace,
              AppText.titleMedium(LocaleKeys.signUp_login.tr()),
              30.verticalSpace,
              AppTextFormField(
                hintText: LocaleKeys.signUp_mobile_number.tr(),
                keyboardType: TextInputType.number,
                valueTransformer: (value) {
                  String manimbulatedValue = '$value';
                  return manimbulatedValue;
                },
                inputFormatters: [
                  FilteringTextInputFormatter.digitsOnly,
                  LengthLimitingTextInputFormatter(10)
                ],
              ),
              20.verticalSpace,
              AppTextFormField(
                isPasswordField: true,
                obscureText: true,
                hintText: LocaleKeys.signUp_EnterYourPassword.tr(),
              ),
              10.verticalSpace,
              TextButton(
                onPressed: () => context.pushNamed(ForgotPasswordPage.name),
                child: AppText.subHeadMedium(
                  LocaleKeys.signUp_ForgetPassword.tr(),
                  color: context.colorScheme.error,
                ),
              ),
              40.verticalSpace,
              RSizedBox(
                width: double.infinity.w,
                child: AppButton.dark(
                  onPressed: () =>
                      context.pushNamed(PhoneVerificationPage.name),
                  stretch: true,
                  title: LocaleKeys.signUp_login.tr(),
                ),
              ),
              20.verticalSpace,
              const WordDivider(),
              20.verticalSpace,
              const CustomSocial(),
              28.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  AppText.bodyMedium(
                      LocaleKeys.signUp_Do_not_have_an_account.tr(),
                      color: context.colorScheme.systemGray.shade700),
                  TextButton(
                      onPressed: () => context.pushNamed(RegisterPage.name),
                      child: AppText.bodyMedium(
                        LocaleKeys.signUp_CreateAccount.tr(),
                      ))
                ],
              ),
            ],
          ),
        ));
  }
}
