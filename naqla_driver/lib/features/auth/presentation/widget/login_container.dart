import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

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
              hintText: S.of(context).phone_verification,
            ),
            16.verticalSpace,
            AppPasswordField(
              name: 'password',
              hintText: S.of(context).enter_Your_Password,
            ),
            32.verticalSpace,
            AppButton.dark(
              title: S.of(context).sign_in,
              onPressed: () async {},
            )
          ],
        ),
      ),
    );
  }
}
