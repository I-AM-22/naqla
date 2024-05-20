import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/features/auth/presentation/widget/sign_up_container.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../app/presentation/widgets/app_scaffold.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});
  static String path = "SignUpPage";
  static String name = "SignUpPage";

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      backgroundColor: Color(0xff222636),
      body: Container(
        margin: REdgeInsets.only(top: 100),
        padding: REdgeInsets.symmetric(
          horizontal: UIConstants.screenPadding30,
          vertical: 50.h,
        ),
        height: context.fullHeight,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(50.r),
            topRight: Radius.circular(50.r),
          ),
        ),
        child: const SignUpContainer(),
      ),
    );
  }
}
