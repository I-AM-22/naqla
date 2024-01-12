import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text_field.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';

import '../../../../generated/locale_keys.g.dart';

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
            title: LocaleKeys.Save.tr(),
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
                LocaleKeys.signUp_set_password.tr(),
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              AppText.bodyRegular(
                LocaleKeys.signUp_set_your_password.tr(),
                textAlign: TextAlign.center,
              ),
              40.verticalSpace,
              AppTextFormField(
                hintText: LocaleKeys.signUp_EnterYourPassword.tr(),
                isPasswordField: true,
                obscureText: true,
              ),
              20.verticalSpace,
              AppTextFormField(
                hintText: LocaleKeys.signUp_Confirm_Password.tr(),
                isPasswordField: true,
                obscureText: true,
              ),
              10.verticalSpace,
              AppText.subHeadMedium(
                LocaleKeys.signUp_At_least_6_number_or_a_special_character.tr(),
                textAlign: TextAlign.right,
                color: context.colorScheme.bodyText,
              ),
            ],
          ),
        ));
  }
}
