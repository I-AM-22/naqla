import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';

class RateWidget extends StatelessWidget {
  RateWidget(
      {super.key,
      ValueNotifier<int>? ratingNotifier,
      this.mainAxisAlignment = MainAxisAlignment.center,
      this.starSize,
      required this.onTap})
      : _rating = ratingNotifier ?? ValueNotifier<int>(0);

  final ValueNotifier<int> _rating;
  final MainAxisAlignment mainAxisAlignment;
  final double? starSize;
  final Function(int) onTap;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mainAxisAlignment,
      children: List.generate(
        5,
        (index) => ValueListenableBuilder(
          valueListenable: _rating,
          builder: (context, value, child) {
            return InkWell(
              onTap: () {
                _rating.value = index + 1;
                onTap(index);
              },
              child: Padding(
                padding: REdgeInsets.symmetric(horizontal: 4),
                child: AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder:
                      (Widget child, Animation<double> animation) =>
                          ScaleTransition(scale: animation, child: child),
                  child: Icon(
                    value < index + 1 ? IconlyLight.star : IconlyBold.star,
                    size: 40.w,
                    key: ValueKey<int>(value < index + 1 ? 0 : 1),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
