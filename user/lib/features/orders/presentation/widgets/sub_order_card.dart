import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/constants/constants.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';
import 'package:naqla/features/orders/presentation/widgets/change_order_status.dart';

import '../../../../core/common/enums/sub_order_status.dart';
import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';

class SubOrderCard extends StatelessWidget {
  const SubOrderCard({super.key, required this.orderModel, required this.index});
  final SubOrderModel orderModel;
  final int index;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<OrderBloc>(),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(border: Border.all(color: context.colorScheme.primary), borderRadius: BorderRadius.circular(8)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
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
                            text:
                                '${CoreHelperFunctions.formatOrderTime(context, orderModel.status, acceptedAt: orderModel.acceptedAt, deliveredAt: orderModel.deliveredAt, driverAssignedAt: orderModel.driverAssignedAt, pickedUpAt: orderModel.pickedUpAt)} \n'),
                        TextSpan(text: '${S.of(context).order_status}${orderModel.status.statusName(context: context)}\n'),
                        if (orderModel.realCost != 0)
                          TextSpan(text: '${S.of(context).cost}${formatter.format(orderModel.realCost)} ${S.of(context).syp}\n'),
                        if ((orderModel.order?.porters ?? 0) > 0) ...{
                          TextSpan(text: '${S.of(context).the_number_of_floors}: ${(orderModel.order?.porters ?? 1) - 1}'),
                        }
                      ]),
                    ),
                  ),
                ),
                // const Spacer(),
                if (orderModel.photos.isNotEmpty)
                  Stack(
                    children: [
                      SizedBox(
                          height: 150.h,
                          width: 150.w,
                          child: AppImage.network(
                            fit: BoxFit.cover,
                            orderModel.photos[0].mobileUrl,
                          )),
                      if (orderModel.photos.length > 1)
                        Container(
                          color: context.colorScheme.primary.withOpacity(.5),
                          child: SizedBox(
                            width: 150.w,
                            height: 200.h,
                            child: Center(
                                child: AppText.titleMedium(
                              '+${orderModel.photos.length - 1}',
                              color: Colors.white,
                            )),
                          ),
                        )
                    ],
                  )
              ],
            ),
            if (orderModel.status == SubOrderStatus.taken) ...{
              ChangeOrderStatusWidget(
                orderId: orderModel.id,
                status: orderModel.status,
                arrivedAt: orderModel.arrivedAt,
                driverAssignedAt: orderModel.driverAssignedAt,
                index: index,
              ),
            }
          ],
        ),
      ),
    );
  }
}
