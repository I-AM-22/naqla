import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text_field.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/features/auth/presentation/pages/set_new_password_page.dart';

class VerificationEmailPage extends StatelessWidget {
  const VerificationEmailPage({super.key});

  static String get path => '/VerificationEmailPage';
  static String get name => '/VerificationEmailPage';

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
            AppText.titleMedium('Verification email or phone number'),
            40.verticalSpace,
            AppTextFormField(
              hintText: 'Email or phone number',
            ),
            const Spacer(),
            AppButton.dark(
              onPressed: () {},
              stretch: true,
              title: 'Send OTP',
            ),
            16.verticalSpace
          ],
        ),
      ),
    );
  }
}
