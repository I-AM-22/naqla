import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

import '../../../../generated/flutter_gen/assets.gen.dart';

class OrderStatusMap extends StatelessWidget {
  const OrderStatusMap({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AppImage.asset(
          Assets.images.jpg.mapBackground.path,
          width: double.infinity,
          fit: BoxFit.cover,
        ),
        Positioned(
          top: 40.h,
          right: 97.w,
          child: Container(
            decoration: BoxDecoration(
              color: context.colorScheme.primary,
              shape: BoxShape.circle,
              border: Border.all(color: context.colorScheme.primary.withOpacity(.2), width: 8, strokeAlign: BorderSide.strokeAlignOutside),
            ),
            height: 20.w,
            width: 20.w,
          ),
        ),
      ],
    );
  }
}
