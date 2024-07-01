import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';

import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';
import '../../../orders/presentation/pages/sub_orders_page.dart';
import '../../data/model/order_model.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.orderModel, required this.showBorder, this.onTap, this.width});
  final OrderModel orderModel;
  final bool showBorder;
  final Function()? onTap;
  final double? width;

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
          context.pushNamed(SubOrdersPage.name, extra: widget.orderModel.id);
        }
      },
      child: Container(
        width: widget.width,
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(
          color: context.colorScheme.surface,
          border: widget.showBorder ? Border.all(color: context.colorScheme.primary) : null,
          borderRadius: BorderRadius.circular(8),
        ),
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
                        TextSpan(text: '${S.of(context).cost}: ${formatter.format(widget.orderModel.paymentModel?.cost)} ${S.of(context).syp}\n'),
                        TextSpan(text: '${S.of(context).order_status} ${widget.orderModel.status.name}\n'),
                        if ((widget.orderModel.porters ?? 0) > 0) ...{
                          TextSpan(text: '${S.of(context).the_number_of_floors}: ${(widget.orderModel.porters ?? 1) - 1}'),
                        }
                      ]),
                    ),
                  ),
                ),
                // const Spacer(),
                Stack(
                  children: [
                    SizedBox(
                        height: 150.h,
                        width: 150.w,
                        child: BlurHash(
                            imageFit: BoxFit.cover, hash: widget.orderModel.photos[0].blurHash, image: widget.orderModel.photos[0].mobileUrl)),
                    if (widget.orderModel.photos.length > 1)
                      Container(
                        color: context.colorScheme.primary.withOpacity(.5),
                        child: SizedBox(
                          width: 150.w,
                          height: 150.w,
                          child: Center(
                              child: AppText.titleMedium(
                            '+${widget.orderModel.photos.length - 1}',
                            color: Colors.white,
                          )),
                        ),
                      )
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
