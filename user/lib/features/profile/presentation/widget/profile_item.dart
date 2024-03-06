import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(
      {super.key,
      required this.title,
      required this.prefixIcon,
      this.suffixIcon,
      this.onTap});
  final String title;
  final String prefixIcon;
  final String? suffixIcon;
  final void Function()? onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
        height: 60.h,
        decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: context.colorScheme.primary50),
        child: Row(
          children: [
            AppImage.asset(
              prefixIcon,
              size: 15,
              color: context.colorScheme.primary,
            ),
            8.horizontalSpace,
            AppText.subHeadMedium(
              title,
            ),
            const Spacer(),
            AppImage.asset(
              suffixIcon ?? context.isArabic
                  ? Assets.icons.arrow.leftArrow.path
                  : Assets.icons.arrow.rightArrow.path,
              size: 15,
            ),
          ],
        ),
      ),
    );
  }
}
