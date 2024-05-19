import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';

class SignUpContainer extends StatefulWidget {
  const SignUpContainer({super.key});

  @override
  State<SignUpContainer> createState() => _SignUpContainerState();
}

class _SignUpContainerState extends State<SignUpContainer> {
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
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              AppText.displayMedium(
                S.of(context).create_an_account,
                color: context.colorScheme.systemGray.shade900,
              ),
              40.verticalSpace,
              Row(
                children: [
                  Expanded(
                    child: AppTextFormField(
                      name: 'firstName',
                      hintText: S.of(context).first_name,
                    ),
                  ),
                  5.horizontalSpace,
                  Expanded(
                    child: AppTextFormField(
                      name: 'lastName',
                      hintText: S.of(context).last_name,
                    ),
                  ),
                ],
              ),
              8.verticalSpace,
              AppTextFormField(
                name: 'mobileNumber',
                hintText: S.of(context).your_mobile_number,
              ),
              16.verticalSpace,
              AppPasswordField(
                name: 'password',
                hintText: S.of(context).enter_Your_Password,
              ),
              32.verticalSpace,
              AppButton.dark(
                title: S.of(context).register,
                onPressed: () async {},
              )
            ],
          ),
        ),
      ),
    );
  }
}
