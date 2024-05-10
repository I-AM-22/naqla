import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';

class OrderStatusIndicator extends StatefulWidget {
  final int currentIndex;
  const OrderStatusIndicator({super.key, required this.currentIndex});

  @override
  State<OrderStatusIndicator> createState() => _OrderStatusIndicatorState();
}

class _OrderStatusIndicatorState extends State<OrderStatusIndicator> with SingleTickerProviderStateMixin {
  late final AnimationController _animationController;

  @override
  void initState() {
    _animationController = AnimationController(vsync: this, duration: const Duration(milliseconds: 500));
    _animationController.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: List.generate(
        4,
        (index) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 500),
            child: Container(
              decoration: BoxDecoration(
                color: (index + 1 <= widget.currentIndex || widget.currentIndex == 3) ? context.colorScheme.primary : Colors.white.withOpacity(.4),
                borderRadius: BorderRadius.circular(5),
              ),
              height: 4.h,
              margin: REdgeInsetsDirectional.only(end: index != 4 ? 8 : 0),
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: (index == widget.currentIndex && widget.currentIndex != 3) ? 1 : 0,
                child: AnimatedBuilder(
                  animation: _animationController,
                  builder: (context, child) {
                    return Transform.scale(
                      scaleX: _animationController.value,
                      alignment: _animationController.status == AnimationStatus.reverse ? Alignment.centerRight : Alignment.centerLeft,
                      child: Container(
                        decoration: BoxDecoration(
                          color: context.colorScheme.primary,
                          borderRadius: BorderRadius.circular(20),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
