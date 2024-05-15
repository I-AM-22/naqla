import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pinput/pinput.dart';
import 'package:naqla/core/core.dart';

class VerificationNumber extends StatelessWidget {
  const VerificationNumber({super.key, this.onCompleted, this.onChanged});
  final Function(String value)? onCompleted;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return Pinput(
      length: 6,
      obscureText: false,
      errorTextStyle: context.textTheme.bodySmall?.copyWith(color: context.colorScheme.error),
      obscuringWidget: Container(
        width: 50.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: context.colorScheme.primary,
          borderRadius: BorderRadius.circular(7),
          border: Border.all(color: context.colorScheme.systemGray.shade200, width: 2),
        ),
      ),
      defaultPinTheme: const PinTheme(),
      animationCurve: Curves.easeInOut,
      animationDuration: const Duration(milliseconds: 300),
      onCompleted: onCompleted,
      onChanged: onChanged,
      cursor: Container(
        width: 50.w,
        height: 48.h,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          borderRadius: BorderRadius.circular(7),
          // shape: BoxShape.circle,
          border: Border.all(color: context.colorScheme.systemGray.shade200, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || (value.isEmpty)) return 'هذا الحقل مطلوب';
        if ((value.length < 6)) return 'كود التحقق يجب نن يتالف من 6 ارقام';
        return null;
      },
      errorPinTheme: const PinTheme().copyWith(
          textStyle: context.textTheme.headlineLarge?.copyWith(color: context.colorScheme.error, fontWeight: FontWeight.w500),
          constraints: BoxConstraints(minHeight: 48.h, minWidth: 50.w),
          decoration: BoxDecoration(
              border: Border.all(
                color: context.colorScheme.error,
              ),
              borderRadius: BorderRadius.circular(8))),
      submittedPinTheme: PinTheme(
        constraints: BoxConstraints(minHeight: 48.h, minWidth: 50.w),
        textStyle: context.textTheme.headlineLarge?.copyWith(color: context.colorScheme.primary, fontWeight: FontWeight.w500),
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
          border: Border.all(color: context.colorScheme.systemGray.shade200, width: 1),
        ),
      ),
    );
  }
}
