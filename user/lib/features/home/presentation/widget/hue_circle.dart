import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

class HueCircle extends StatelessWidget {
  const HueCircle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 1.w,
      width: 1.w,
      decoration: BoxDecoration(
        boxShadow: [
          BoxShadow(
            color: context.colorScheme.primary,
            blurRadius: 100,
            spreadRadius: 70,
          )
        ],
        shape: BoxShape.circle,
      ),
    );
  }
}
