import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/core.dart';

class PhotoCardWidget extends StatelessWidget {
  const PhotoCardWidget({super.key, required this.photoPath, this.width, this.height, required this.length});
  final String photoPath;
  final int length;
  final double? width;
  final double? height;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        SizedBox(
            height: height ?? 150.h,
            width: width ?? 150.w,
            child: AppImage.network(
              fit: BoxFit.cover,
              photoPath,
            )),
        if (length > 1)
          Container(
            color: context.colorScheme.primary.withOpacity(.5),
            child: SizedBox(
              width: 150.w,
              height: 200.h,
              child: Center(
                  child: AppText.titleMedium(
                '+${length - 1}',
                color: Colors.white,
              )),
            ),
          )
      ],
    );
  }
}
