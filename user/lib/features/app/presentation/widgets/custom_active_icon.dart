import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

class CustomActiveIcon extends StatelessWidget {
  const CustomActiveIcon({
    super.key,
    required this.label,
    required this.image,
    this.foregroundColor,
    this.backgroundColor,
  });

  final String label;

  final String image;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        AppImage.asset(
          image,
          width: 24.w,
          height: 24.h,
          color: foregroundColor ?? context.colorScheme.primary,
        ),
        6.verticalSpace,
        AppText.bodySmMedium(
          label,
          color: foregroundColor ?? context.colorScheme.primary,
          textAlign: TextAlign.center,
        ),
      ],
    );
  }
}
