import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

class CustomActiveIcon extends StatelessWidget {
  const CustomActiveIcon({
    super.key,
    required this.label,
    this.foregroundColor,
    this.backgroundColor,
    required this.iconData,
  });

  final String label;

  final IconData iconData;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          iconData,
          color: context.colorScheme.primary,
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
