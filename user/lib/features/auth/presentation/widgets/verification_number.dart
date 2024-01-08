import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:user/core/core.dart';

class VerificationNumber extends StatelessWidget {
  const VerificationNumber({super.key});

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 5,
      obscureText: false,
      obscuringWidget: Container(
        width: 50.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
              color: context.colorScheme.systemGray.shade200, width: 2),
        ),
      ),
      defaultPinTheme: const PinTheme(),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      cursor: Container(
        width: 50.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: context.colorScheme.background,
          borderRadius: BorderRadius.circular(7),
          // shape: BoxShape.circle,
          border: Border.all(
              color: context.colorScheme.systemGray.shade200, width: 2),
        ),
      ),
      submittedPinTheme: PinTheme(
        constraints: BoxConstraints(minHeight: 48.h, minWidth: 50.w),
        textStyle: context.textTheme.headlineLarge?.copyWith(
            color: context.colorScheme.primary, fontWeight: FontWeight.w500),
        decoration: BoxDecoration(
          border: Border.all(color: context.colorScheme.primary),
          borderRadius: BorderRadius.circular(8),
          color: const Color(0xFFFFFDE7),
        ),
      ),
      preFilledWidget: Container(
        width: 50.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: context.colorScheme.onPrimary,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(
              color: context.colorScheme.systemGray.shade200, width: 1),
        ),
      ),
    );
  }
}
