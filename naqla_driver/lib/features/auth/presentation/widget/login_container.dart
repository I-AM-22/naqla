import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/auth/presentation/pages/sign_in_page.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';

class LoginContainer extends StatefulWidget {
  const LoginContainer({super.key});

  @override
  State<LoginContainer> createState() => _LoginContainerState();
}

class _LoginContainerState extends State<LoginContainer> {
  final GlobalKey<FormBuilderState> _formKey = GlobalKey<FormBuilderState>();

  @override
  Widget build(BuildContext context) {
    return FormBuilder(
      key: _formKey,
      child: SingleChildScrollView(
        child: Container(
          padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding30, vertical: 47),
          width: 1.sw,
          height: 513.h,
          decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50.r),
              topRight: Radius.circular(50.r),
            ),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.displayMedium(
                S.of(context).Welcome,
                color: context.colorScheme.systemGray.shade900,
              ),
              40.verticalSpace,
              AppTextFormField(
                name: 'mobileNumber',
                hintText: S.of(context).your_mobile_number,
              ),
              32.verticalSpace,
              AppButton.dark(
                title: S.of(context).sign_in,
                onPressed: () async {},
              ),
              23.verticalSpace,
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Flexible(
                    flex: 3,
                    child: AppText.bodyMedium(S.of(context).do_not_have_an_account, color: context.colorScheme.systemGray.shade700),
                  ),
                  Flexible(
                    flex: 2,
                    child: TextButton(
                        onPressed: () => context.pushNamed(SignUpPage.name),
                        child: AppText.bodyMedium(
                          S.of(context).sign_up,
                          fontWeight: FontWeight.bold,
                        )),
                  )
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
