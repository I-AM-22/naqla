import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text_field.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';

import '../set_profile_page.dart';

class SetPasswordPage extends StatelessWidget {
  const SetPasswordPage({super.key});

  static String get path => '/SetPasswordPage';
  static String get name => '/SetPasswordPage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: CustomerAppBar(
          appBarParams: AppBarParams(),
          back: true,
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              30.verticalSpace,
              Center(
                child: Column(
                  children: [
                    AppText.titleMedium(
                      'Set Password',
                      textAlign: TextAlign.center,
                    ),
                    12.verticalSpace,
                    AppText.bodyRegular(
                      'Set your password',
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
              40.verticalSpace,
              AppTextFormField(
                hintText: 'Enter Your Passwor',
                isPasswordField: true,
                obscureText: true,
              ),
              20.verticalSpace,
              AppTextFormField(
                hintText: 'Confirm Password',
                obscureText: true,
                isPasswordField: true,
              ),
              10.verticalSpace,
              AppText.subHeadMedium(
                'Atleast 1 number or a special character',
                color: context.colorScheme.bodyText,
                textAlign: TextAlign.right,
              ),
              43.verticalSpace,
              AppButton.dark(
                onPressed: () => context.pushNamed(SetProfilePage.name),
                stretch: true,
                title: 'Register',
              )
            ],
          ),
        ));
  }
}
