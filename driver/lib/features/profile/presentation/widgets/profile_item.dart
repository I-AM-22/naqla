import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/flutter_gen/assets.gen.dart';

class ProfileItem extends StatelessWidget {
  const ProfileItem(
      {super.key,
      required this.title,
      required this.prefixIcon,
      this.suffixIcon,
      this.onTap,
      this.isFlag = false,
      this.width,
      this.height,
      this.isSelected = true,
      this.suffixIconColor});
  final String title;
  final Widget prefixIcon;
  final String? suffixIcon;
  final void Function()? onTap;
  final bool isFlag;
  final double? width;
  final double? height;
  final bool isSelected;
  final Color? suffixIconColor;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        alignment: AlignmentDirectional.centerStart,
        padding: REdgeInsets.symmetric(horizontal: UIConstants.screenPadding16),
        height: 60.h,
        decoration: BoxDecoration(
          boxShadow: [BoxShadow(color: context.colorScheme.black.withOpacity(.24), offset: const Offset(0, 0), blurRadius: 1)],
          border: Border.all(color: isSelected ? context.colorScheme.primary : context.colorScheme.systemGray.shade200),
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.onPrimary,
        ),
        child: Row(
          children: [
            prefixIcon,
            8.horizontalSpace,
            AppText.subHeadMedium(
              title,
            ),
            const Spacer(),
            AppImage.asset(
              (suffixIcon != null)
                  ? suffixIcon!
                  : context.isArabic
                      ? Assets.icons.arrow.leftArrow.path
                      : Assets.icons.arrow.rightArrow.path,
              size: 15,
              color: suffixIconColor,
            ),
          ],
        ),
      ),
    );
  }
}
