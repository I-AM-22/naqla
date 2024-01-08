import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/config/themes/utils.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text_field.dart';
import 'package:user/features/app/presentation/widgets/app_scaffold.dart';
import 'package:user/features/app/presentation/widgets/customer_appbar.dart';
import 'package:user/features/app/presentation/widgets/params_appbar.dart';
import 'package:user/generated/flutter_gen/assets.gen.dart';

import '../widgets/mobile_number_field.dart';

class SetProfilePage extends StatelessWidget {
  const SetProfilePage({super.key});

  static String get path => '/SetProfilePage';

  static String get name => '/SetProfilePage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      appBar: CustomerAppBar(
          back: true, appBarParams: AppBarParams(title: 'Profile')),
      body: Padding(
        padding: REdgeInsets.symmetric(horizontal: kpPaddingPage),
        child: ListView(
          children: [
            30.verticalSpace,
            Center(
              child: Stack(
                alignment: Alignment.bottomRight,
                children: [
                  CircleAvatar(
                    radius: 60,
                    backgroundColor: context.colorScheme.systemGray.shade200,
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
            30.verticalSpace,
            AppTextFormField(
              hintText: 'Name',
            ),
            20.verticalSpace,
            const AppMobileNumberField(),
            20.verticalSpace,
            AppTextFormField(
              hintText: 'Email',
            ),
            20.verticalSpace,
            AppTextFormField(
              hintText: 'street',
            ),
            20.verticalSpace,
            const AppMobileNumberField(
              hintText: 'City',
              isPassword: false,
            ),
            20.verticalSpace,
            const AppMobileNumberField(
              hintText: 'District',
              isPassword: false,
            ),
            40.verticalSpace,
            Row(
              children: [
                const Expanded(
                  child: AppButton.dark(
                    title: 'Save',
                  ),
                ),
                15.horizontalSpace,
                Expanded(
                  child: AppButton.tertiary(
                    onPressed: () {},
                    title: 'Cancel',
                    buttonSize: ButtonSize.large,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
