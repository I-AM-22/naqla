import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:iconly/iconly.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/core_helper_functions.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/order_model.dart';
import 'hue_circle.dart';
import 'order_status_header.dart';
import 'order_status_indicator.dart';
import 'order_status_map.dart';

class OrderStatusCard extends StatefulWidget {
  final List<OrderModel> orders;

  const OrderStatusCard({super.key, required this.orders});

  @override
  State<OrderStatusCard> createState() => _OrderStatusCardState();
}

class _OrderStatusCardState extends State<OrderStatusCard> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemCount: widget.orders.length,
      itemBuilder: (context, index) => Container(
        height: 250.h,
        width: 360.w,
        clipBehavior: Clip.antiAlias,
        margin: REdgeInsets.only(
          left: UIConstants.screenPadding20,
          right: UIConstants.screenPadding20,
          top: UIConstants.screenPadding30,
        ),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: context.colorScheme.primary.withOpacity(.7),
        ),
        child: Stack(
          alignment: Alignment.centerLeft,
          clipBehavior: Clip.antiAlias,
          children: [
            AnimatedPositioned(
              duration: const Duration(milliseconds: 500),
              // left: widget.orders[index].orderStatus.index * 100.w,
              child: AnimatedOpacity(
                duration: const Duration(milliseconds: 500),
                opacity: widget.orders[index].status.index == 2 ? 0 : 1,
                child: const HueCircle(),
              ),
            ),
            AnimatedOpacity(
              opacity: widget.orders[index].status.index == 2 ? 1 : 0,
              duration: const Duration(milliseconds: 500),
              child: const OrderStatusMap(),
            ),
            Padding(
              padding: REdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                      child: OrderStatusHeader(
                    currentIndex: widget.orders[index].status.index,
                    order: widget.orders[index],
                  )),
                  OrderStatusIndicator(currentIndex: widget.orders[index].status.index),
                  12.verticalSpace,
                  AppText.subHeadMedium('${S.of(context).order_date} ${CoreHelperFunctions.fromDateTimeToString(widget.orders[index].desiredDate)}',
                      maxLines: 1, overflow: TextOverflow.ellipsis, color: Colors.white),
                  12.verticalSpace,
                  AppButton.field(
                    stretch: true,
                    title: S.of(context).order_details,
                    onPressed: () {},
                    postfixIcon: const Icon(IconlyBroken.arrow_left),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
