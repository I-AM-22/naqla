import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/home/data/model/order_model.dart';

class OrderStatusHeader extends StatelessWidget {
  final int currentIndex;
  final OrderModel order;
  const OrderStatusHeader({super.key, required this.currentIndex, required this.order});

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        AnimatedPositioned(
          duration: const Duration(milliseconds: 400),
          top: currentIndex == 2 ? 60 : 0,
          child: Container(
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(borderRadius: BorderRadius.circular(8), color: context.colorScheme.primary),
            child: AnimatedSwitcher(
              duration: const Duration(milliseconds: 300),
              transitionBuilder: (child, animation) => FadeTransition(opacity: animation, child: child),
              child: [
                AppText.labelMedium("قيد الانتظار", color: Colors.white, key: UniqueKey()),
                AppText.labelMedium('طلبك مقبلول', color: Colors.white, key: UniqueKey()),
                AppText.labelMedium('طلبك على الطريق', color: Colors.white, key: UniqueKey()),
                AppText.labelMedium('order_delivered', color: Colors.white, key: UniqueKey()),
              ][currentIndex],
            ),
          ),
        ),
      ],
    );
  }
}
