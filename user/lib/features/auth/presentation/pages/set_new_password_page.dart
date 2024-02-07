import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/config/themes/utils.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/global_widgets/app_text_field.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';

class SetNewPasswordPage extends StatelessWidget {
  const SetNewPasswordPage({super.key});
  static String get path => '/SetNewPasswordPage';
  static String get name => '/SetNewPasswordPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        bottomNavigationBar: Padding(
          padding:
              REdgeInsets.symmetric(horizontal: kpPaddingPage, vertical: 10),
          child: AppButton.dark(
            onPressed: () {},
            stretch: true,
            title: 'LocaleKeys.Save.tr()',
          ),
        ),
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
                'LocaleKeys.signUp_set_password.tr()',
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              AppText.bodyRegular(
                'LocaleKeys.signUp_set_your_password.tr()',
                textAlign: TextAlign.center,
              ),
              40.verticalSpace,
              AppTextFormField(
                hintText: 'LocaleKeys.signUp_EnterYourPassword.tr()',
                isPasswordField: true,
                obscureText: true,
              ),
              20.verticalSpace,
              AppTextFormField(
                hintText: '',
                isPasswordField: true,
                obscureText: true,
              ),
              10.verticalSpace,
              AppText.subHeadMedium(
                '',
                textAlign: TextAlign.right,
                color: context.colorScheme.bodyText,
              ),
            ],
          ),
        ));
  }
}
