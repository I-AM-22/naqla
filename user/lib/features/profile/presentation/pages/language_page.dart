import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/app/presentation/pages/app.dart';
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
          appBarParams: AppBarParams(title: S.of(context).change_language),
        ),
        body: Padding(
          padding: REdgeInsets.symmetric(vertical: UIConstants.screenPadding30, horizontal: UIConstants.screenPadding16),
          child: Column(
            children: [
              ProfileItem(
                title: S.of(context).english,
                isFlag: true,
                width: 25.w,
                height: 25.h,
                prefixIcon: AppImage.asset(
                  Assets.icons.flags.english.path,
                  size: 15,
                ),
                isSelected: !context.isArabic,
                suffixIconColor: !context.isArabic ? context.colorScheme.primary : context.colorScheme.systemGray,
                suffixIcon: context.isArabic ? Assets.icons.essential.checkCircle.path : Assets.icons.essential.checkCircle2.path,
                onTap: () => App.englishLanguage.value = true,
              ),
              16.verticalSpace,
              ProfileItem(
                title: S.of(context).arabic,
                isFlag: true,
                width: 25.w,
                height: 25.h,
                prefixIcon: AppImage.asset(
                  Assets.icons.flags.syria.path,
                  size: 15,
                ),
                isSelected: context.isArabic,
                suffixIconColor: context.isArabic ? context.colorScheme.primary : context.colorScheme.systemGray,
                suffixIcon: context.isArabic ? Assets.icons.essential.checkCircle2.path : Assets.icons.essential.checkCircle.path,
                onTap: () => App.englishLanguage.value = false,
              ),
            ],
          ),
        ));
  }
}
