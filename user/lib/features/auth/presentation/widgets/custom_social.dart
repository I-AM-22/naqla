import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:user/core/core.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';

class CustomSocial extends StatelessWidget {
  const CustomSocial({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: AppButton.ghost(
            textStyle: context.textTheme.subHeadWebMedium
                .copyWith(color: context.colorScheme.primary),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                side: BorderSide(
                    color: context.colorScheme.systemGray.shade200, width: 1)),
            fixedSize: Size.fromHeight(48.h),
            child: Center(
                child: AppImage.asset(Assets.icons.social.gmail.path,
                    height: 24.w, width: 24.w)),
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: AppButton.ghost(
            textStyle: context.textTheme.subHeadWebMedium
                .copyWith(color: context.colorScheme.primary),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                side: BorderSide(
                    color: context.colorScheme.systemGray.shade200, width: 1)),
            fixedSize: Size.fromHeight(48.h),
            child: Center(
                child: AppImage.asset(Assets.icons.social.facebook.path,
                    height: 24.w, width: 24.w)),
          ),
        ),
        16.horizontalSpace,
        Expanded(
          child: AppButton.ghost(
            textStyle: context.textTheme.subHeadWebMedium
                .copyWith(color: context.colorScheme.primary),
            onPressed: () {},
            style: ElevatedButton.styleFrom(
                side: BorderSide(
                    color: context.colorScheme.systemGray.shade200, width: 1)),
            fixedSize: Size.fromHeight(48.h),
            child: Center(
                child: AppImage.asset(Assets.icons.social.apple.path,
                    height: 24.w, width: 40.w)),
          ),
        ),
      ],
    );
  }
}
