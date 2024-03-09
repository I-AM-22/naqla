import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

import '../../../profile/presentation/widget/drop_down_language.dart';

class DrawerItem extends StatelessWidget {
  const DrawerItem(
      {super.key,
      required this.icon,
      required this.title,
      this.lastItem = false,
      this.showDropDown = false,
      this.onTap,
      this.mainAxisAlignment});
  final String icon;
  final String title;
  final bool lastItem;
  final bool showDropDown;
  final void Function()? onTap;
  final MainAxisAlignment? mainAxisAlignment;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        children: [
          Row(
            mainAxisAlignment: mainAxisAlignment ?? MainAxisAlignment.start,
            children: [
              Row(
                children: [
                  AppImage.asset(icon, size: 16),
                  12.horizontalSpace,
                  AppText.labelMedium(title),
                ],
              ),
              if (showDropDown) CustomDropDownLanguage()
            ],
          ),
          15.verticalSpace,
          if (!lastItem)
            Divider(
              color: context.colorScheme.systemGray.shade100,
              thickness: 2,
            ),
          15.verticalSpace,
        ],
      ),
    );
  }
}
