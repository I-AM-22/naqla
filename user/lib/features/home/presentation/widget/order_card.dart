import 'package:flutter/material.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/features/home/presentation/widget/order_status_indicator.dart';

import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';
import '../../data/model/order_model.dart';

class OrderCard extends StatefulWidget {
  const OrderCard({super.key, required this.orderModel});
  final OrderModel orderModel;

  @override
  State<OrderCard> createState() => _OrderCardState();
}

class _OrderCardState extends State<OrderCard> with SingleTickerProviderStateMixin {
  @override
  Widget build(BuildContext context) {
    return Container(
      clipBehavior: Clip.antiAliasWithSaveLayer,
      decoration: BoxDecoration(
        border: Border.all(color: context.colorScheme.primary),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    10.verticalSpace,
                    AppText.bodySmMedium('${S.of(context).order_date} ${CoreHelperFunctions.fromDateTimeToString(widget.orderModel.desiredDate)}'),
                    10.verticalSpace,
                    AppText.bodySmMedium('${S.of(context).order_status} ${widget.orderModel.status.name}'),
                    10.verticalSpace,
                    AppText.bodySmMedium('${S.of(context).cost} ${widget.orderModel.paymentModel?.cost} ${S.of(context).syp}'),
                  ],
                ),
              ),
              // const Spacer(),
              Stack(
                children: [
                  SizedBox(
                      height: 150.h,
                      width: 150.w,
                      child:
                          BlurHash(imageFit: BoxFit.cover, hash: widget.orderModel.photos[0].blurHash, image: widget.orderModel.photos[0].mobileUrl)),
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
          OrderStatusIndicator()
        ],
      ),
    );
  }
}
