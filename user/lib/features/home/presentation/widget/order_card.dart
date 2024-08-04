import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/orders/presentation/widgets/photo_card_widget.dart';

import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';
import '../../../orders/presentation/pages/sub_orders_page.dart';
import '../../data/model/order_model.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.orderModel, required this.showBorder, this.onTap, this.width, required this.isWaiting});
  final OrderModel orderModel;
  final bool showBorder;
  final Function()? onTap;
  final double? width;
  final bool isWaiting;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (widget.onTap != null) {
          widget.onTap!();
        } else {
          context.pushNamed(SubOrdersPage.name, extra: SubOrderParam(orderId: widget.orderModel.id, isWaiting: widget.isWaiting));
        }
      },
      child: Container(
        width: widget.width,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
            color: context.colorScheme.surface,
            borderRadius: BorderRadius.circular(8),
            boxShadow: [BoxShadow(color: context.colorScheme.outline, offset: Offset(0, 1), blurRadius: 2)]),
        child: Column(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Flexible(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: RichText(
                      text: TextSpan(style: context.textTheme.subHeadMedium.copyWith(color: context.colorScheme.primary, height: 1.5), children: [
                        TextSpan(
                            text: '${S.of(context).order_date}${CoreHelperFunctions.fromOrderDateTimeToString(widget.orderModel.desiredDate)}\n'),
                        if ((widget.orderModel.paymentModel?.cost ?? 0) > 0)
                          TextSpan(text: '${S.of(context).cost}: ${formatter.format(widget.orderModel.paymentModel?.cost)} ${S.of(context).syp}\n'),
                        TextSpan(text: '${S.of(context).order_status} ${widget.orderModel.status.statusName(context: context)}\n'),
                        if ((widget.orderModel.porters ?? 0) > 0) ...{
                          TextSpan(text: '${S.of(context).the_number_of_floors}: ${(widget.orderModel.porters ?? 1) - 1}'),
                        }
                      ]),
                    ),
                  ),
                ),
                if (widget.orderModel.photos.isNotEmpty)
                  PhotoCardWidget(
                    photoPath: widget.orderModel.photos[0].mobileUrl,
                    length: widget.orderModel.photos.length,
                    height: 160.h,
                  )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
