import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/features/app/presentation/widgets/app_scaffold.dart';
import 'package:naqla/features/app/presentation/widgets/customer_appbar.dart';
import 'package:naqla/features/app/presentation/widgets/params_appbar.dart';
import 'package:naqla/features/profile/presentation/widget/profile_item.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';

class LanguagePage extends StatelessWidget {
  const LanguagePage({super.key});

  static String name = 'LanguagePage';

  static String path = 'LanguagePage';

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        appBar: AppAppBar(
          appBarParams: AppBarParams(title: ''),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(
              vertical: UIConstants.screenPadding30,
              horizontal: UIConstants.screenPadding16),
          child: Column(
            children: [
              ProfileItem(
                title: S.of(context).language,
                isFlag: true,
                width: 25.w,
                height: 25.h,
                prefixIcon: Assets.icons.flags.english.path,
                suffixIcon: Assets.icons.essential.checkCircle2.path,
              ),
              16.verticalSpace,
              ProfileItem(
                title: S.of(context).language,
                isFlag: true,
                width: 25.w,
                height: 25.h,
                prefixIcon: Assets.icons.flags.syria.path,
                suffixIcon: Assets.icons.essential.checkCircle.path,
              ),
            ],
          ),
        ));
  }
}
