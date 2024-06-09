import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

class CustomActiveIcon extends StatelessWidget {
  const CustomActiveIcon({
    super.key,
    required this.label,
    required this.icon,
    this.foregroundColor,
    this.backgroundColor,
  });

  final String label;

  final IconData icon;
  final Color? foregroundColor;
  final Color? backgroundColor;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Icon(
          icon,
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
