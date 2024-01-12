import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text_field.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';

class SetNewPasswordPage extends StatelessWidget {
  const SetNewPasswordPage({super.key});
  static String get path => '/SetNewPasswordPage';
  static String get name => '/SetNewPasswordPage';

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
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              30.verticalSpace,
              AppText.titleMedium(
                'Set New password',
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              AppText.bodyRegular(
                'Set your new password',
                textAlign: TextAlign.center,
              ),
              40.verticalSpace,
              AppTextFormField(
                hintText: 'Enter Your New Password',
                isPasswordField: true,
                obscureText: true,
              ),
              20.verticalSpace,
              AppTextFormField(
                hintText: 'Confirm Password',
                isPasswordField: true,
                obscureText: true,
              ),
              10.verticalSpace,
              AppText.subHeadMedium(
                'Atleast 1 number or a special character',
                textAlign: TextAlign.right,
                color: context.colorScheme.bodyText,
              ),
              const Spacer(),
              AppButton.dark(
                onPressed: () {},
                stretch: true,
                title: 'Save',
              ),
              16.verticalSpace
            ],
          ),
        ));
  }
}
