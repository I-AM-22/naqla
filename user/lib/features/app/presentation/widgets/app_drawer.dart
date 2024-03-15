import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/profile/presentation/pages/profile_page.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';
import '../../../../generated/l10n.dart';
import 'drawer_item.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: context.isArabic
          ? const BorderRadius.only(topLeft: Radius.circular(80), bottomLeft: Radius.circular(80))
          : const BorderRadius.only(topRight: Radius.circular(80), bottomRight: Radius.circular(80)),
      child: Drawer(
        backgroundColor: context.colorScheme.onPrimary,
        child: ListView(
          padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16, vertical: UIConstants.screenPadding30),
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                AppImage.asset(context.isArabic ? Assets.icons.arrow.rightArrow.path : Assets.icons.arrow.leftArrow.path),
                AppText.subHeadMedium(S.of(context).back),
              ],
            ),
            27.verticalSpace,
            const Align(
              alignment: AlignmentDirectional.topStart,
              child: CircleAvatar(
                radius: 50,
              ),
            ),
            18.verticalSpace,
            AppText.headlineSmall('majed'),
            AppText.bodySmall('majed@gmail.com'),
            40.verticalSpace,
            DrawerItem(icon: Assets.icons.essential.profile.path, title: S.of(context).edit_profile),
            DrawerItem(icon: Assets.icons.essential.info.path, title: S.of(context).about_us),
            DrawerItem(icon: Assets.icons.essential.info.path, title: S.of(context).help_and_support),
            DrawerItem(
              icon: Assets.icons.essential.website.path,
              title: S.of(context).language,
              showDropDown: true,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
            ),
            DrawerItem(
              icon: Assets.icons.essential.logout.path,
              title: S.of(context).logOut,
              lastItem: true,
              onTap: () {
                context.pop();
                Logout.logOut(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
