import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text_field.dart';
import 'package:user/core/global_widgets/word_divider.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/features/auth/presentation/pages/forgot_password_page.dart';
import 'package:user/features/auth/presentation/pages/verification_email_page.dart';
import 'package:user/features/auth/presentation/widgets/custom_social.dart';

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
          child: ListView(
            children: [
              30.verticalSpace,
              AppText.titleMedium('Sign in'),
              30.verticalSpace,
              AppTextFormField(
                hintText: 'Email or Phone Number',
              ),
              30.verticalSpace,
              AppTextFormField(
                isPasswordField: true,
                obscureText: true,
                hintText: 'Enter Your Password',
              ),
              10.verticalSpace,
              Align(
                alignment: AlignmentDirectional.topEnd,
                child: TextButton(
                  onPressed: () => context.pushNamed(ForgotPasswordPage.name),
                  child: AppText.subHeadMedium(
                    'Forget password?',
                    color: context.colorScheme.error,
                  ),
                ),
              ),
              40.verticalSpace,
              AppButton.dark(
                onPressed: () => context.pushNamed(VerificationEmailPage.name),
                stretch: true,
                title: 'Sign In',
              ),
              20.verticalSpace,
              const WordDivider(),
              20.verticalSpace,
              const CustomSocial(),
              28.verticalSpace,
              Text.rich(
                  textAlign: TextAlign.center,
                  style: context.textTheme.bodyMedium
                      ?.copyWith(color: context.colorScheme.primary),
                  TextSpan(children: [
                    TextSpan(
                        text: 'Don’t have an account? ',
                        style: context.textTheme.bodyMedium?.copyWith(
                            color: context.colorScheme.systemGray.shade700)),
                    const TextSpan(text: 'Sign Up')
                  ]))
            ],
          ),
        ));
  }
}
