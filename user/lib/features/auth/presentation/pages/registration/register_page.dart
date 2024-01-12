import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/config/themes/utils.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/global_widgets/app_text_field.dart';
import 'package:naqla/core/global_widgets/word_divider.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/auth/presentation/pages/registration/phone_verfication.dart';
import 'package:naqla/features/auth/presentation/pages/sign_in_page.dart';
import 'package:naqla/features/auth/presentation/widgets/custom_social.dart';
import 'package:naqla/generated/flutter_gen/assets.gen.dart';
import 'package:naqla/generated/locale_keys.g.dart';

import '../../widgets/mobile_number_field.dart';

class RegisterPage extends StatelessWidget {
  const RegisterPage({super.key});
  static String get name => '/RegisterPage';
  static String get path => '/RegisterPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        resizeToAvoidBottomInset: false,
        appBar: CustomerAppBar(back: true, appBarParams: AppBarParams()),
        body: Container(
          padding: REdgeInsets.symmetric(horizontal: kpPaddingPage),
          height: context.bodyHeight,
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                AppText.titleMedium(
                  LocaleKeys.signUp_sign_up.tr(),
                ),
                30.verticalSpace,
                Center(
                  child: Stack(
                    alignment: Alignment.bottomRight,
                    children: [
                      CircleAvatar(
                        radius: 60,
                        backgroundColor:
                            context.colorScheme.systemGray.shade200,
                      ),
                      CircleAvatar(
                        backgroundColor: context.colorScheme.primary,
                        child: AppImage.asset(
                          Assets.icons.essential.camera.path,
                          size: 30.r,
                          color: Colors.white,
                        ),
                      )
                    ],
                  ),
                ),
                20.verticalSpace,
                Row(
                  children: [
                    Expanded(
                      child: AppTextFormField(
                        hintText: LocaleKeys.signUp_first_name.tr(),
                      ),
                    ),
                    8.horizontalSpace,
                    Expanded(
                      child: AppTextFormField(
                        hintText: LocaleKeys.signUp_last_name.tr(),
                      ),
                    ),
                  ],
                ),
                20.verticalSpace,
                AppTextFormField(
                  hintText: LocaleKeys.signUp_mobile_number.tr(),
                ),
                20.verticalSpace,
                AppMobileNumberField(
                  hintText: LocaleKeys.signUp_city.tr(),
                  isPassword: false,
                ),
                20.verticalSpace,
                AppButton.dark(
                  onPressed: () =>
                      context.pushNamed(PhoneVerificationPage.name),
                  stretch: true,
                  title: LocaleKeys.signUp_sign_up.tr(),
                  fixedSize: Size.fromHeight(48.h),
                ),
                20.verticalSpace,
                const WordDivider(),
                15.verticalSpace,
                const CustomSocial(),
                40.verticalSpace,
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    AppText.bodyMedium(
                        LocaleKeys.signUp_Already_have_an_account.tr(),
                        color: context.colorScheme.systemGray.shade700),
                    TextButton(
                        onPressed: () => context.pushNamed(SignInPage.name),
                        child: AppText.bodyMedium(
                          LocaleKeys.signUp_login.tr(),
                        ))
                  ],
                ),
                20.verticalSpace
              ],
            ),
          ),
        ));
  }
}
