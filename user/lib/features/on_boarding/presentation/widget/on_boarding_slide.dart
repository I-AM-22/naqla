import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:lottie/lottie.dart';
import 'package:user/core/config/themes/my_color_scheme.dart';
import 'package:user/core/core.dart';
import 'package:user/core/global_widgets/app_text.dart';
import 'package:user/core/util/extensions/build_context.dart';

import '../../../../core/util/responsive_padding.dart';

class OnBoardingSlide extends StatelessWidget {
  const OnBoardingSlide(
      {super.key,
      required this.title,
      required this.content,
      required this.path,
      required this.num,
      required this.onPressed});
  final String title;
  final String content;
  final String path;
  final double num;
  final void Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        const Spacer(flex: 1),
        Padding(
          padding: HWEdgeInsets.symmetric(horizontal: 10),
          child: Lottie.asset(path),
        ),
        const Spacer(),
        Padding(
          padding: HWEdgeInsets.symmetric(horizontal: 56),
          child: Column(
            children: [
              AppText.titleMedium(
                title,
                textAlign: TextAlign.center,
              ),
              12.verticalSpace,
              AppText.subHeadMedium(
                content,
                textAlign: TextAlign.center,
                color: context.colorScheme.systemGray.shade400,
              ),
            ],
          ),
        ),
        const Spacer(),
        CustomPaint(
          size: Size(88.r, 88.r),
          painter: ArcIndicator(
              context: context, percent: 0.4, width: 2.w, num: num),
          child: Container(
            height: 70.r,
            width: 70.r,
            decoration: BoxDecoration(
                border: Border.all(
                  color: context.colorScheme.systemGray,
                ),
                color: context.colorScheme.baseColor,
                shape: BoxShape.circle),
            child: Center(
                child: num == 2.5
                    ? Text(
                        'GO',
                        style: context.textTheme.labelMedium!
                            .copyWith(color: context.colorScheme.textAndIcon),
                      )
                    : IconButton(
                        onPressed: onPressed,
                        icon: Icon(
                          Icons.arrow_forward,
                          color: context.colorScheme.textAndIcon,
                        ),
                      )),
          ),
        ),
        const Spacer(
          flex: 2,
        )
      ],
    );
  }
}

class ArcIndicator extends CustomPainter {
  final double percent;
  final double width;
  final BuildContext context;
  final double num;

  ArcIndicator(
      {required this.context,
      required this.percent,
      required this.width,
      required this.num});

  @override
  void paint(Canvas canvas, Size size) {
    Offset offset = Offset(size.width / 2, size.height / 2);
    double radius = min(size.width / 1.8, size.height / 1.8);

    final paint = Paint()
      ..shader = RadialGradient(
        colors: [
          context.colorScheme.primary,
          context.colorScheme.primary,
        ],
      ).createShader(Rect.fromCircle(center: offset, radius: radius))
      ..strokeCap = StrokeCap.round
      ..strokeWidth = width
      ..style = PaintingStyle.stroke;

    canvas.drawArc(Rect.fromCircle(center: offset, radius: radius), 0.4,
        -num * pi * 0.8, false, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
