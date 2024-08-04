import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/common/enums/order_status.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/orders/presentation/widgets/photo_card_widget.dart';
import 'package:naqla_driver/features/orders/presentation/widgets/set_order_delivered_button.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/model/sub_order_model.dart';

class SubOrderCard extends StatelessWidget {
  const SubOrderCard({super.key, required this.subOrderModel});
  final SubOrderModel subOrderModel;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: UIConstants.screenPadding16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: context.colorScheme.primary.withOpacity(.2), blurRadius: 5, offset: const Offset(0, 2))],
        ),
        child: Container(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          decoration: BoxDecoration(
            border: Border.all(color: context.colorScheme.primary),
            borderRadius: BorderRadius.circular(8),
          ),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Padding(
                      padding: REdgeInsets.all(10),
                      child: RichText(
                        text: TextSpan(style: context.textTheme.subHeadMedium.copyWith(color: context.colorScheme.primary), children: [
                          TextSpan(text: '${S.of(context).weight}${subOrderModel.weight},'),
                          WidgetSpan(child: 5.horizontalSpace),
                          TextSpan(text: '${S.of(context).cost}${formatter.format(subOrderModel.cost)} ${S.of(context).syp}\n'),
                          if ((subOrderModel.order?.porters ?? 0) > 0) ...{
                            TextSpan(text: '${S.of(context).the_number_of_floors}: ${(subOrderModel.order?.porters ?? 1) - 1}\n'),
                          },
                          TextSpan(text: '${S.of(context).order_status}: ${subOrderModel.status?.statusName(context: context)}\n'),
                          TextSpan(
                              text: CoreHelperFunctions.formatOrderTime(context, subOrderModel.status!,
                                  pickedUpAt: subOrderModel.pickedUpAt,
                                  driverAssignedAt: subOrderModel.driverAssignedAt,
                                  acceptedAt: subOrderModel.acceptedAt,
                                  deliveredAt: subOrderModel.deliveredAt)),
                        ]),
                      ),
                    ),
                  ),
                  if (subOrderModel.photos.isNotEmpty) ...{
                    PhotoCardWidget(
                      length: subOrderModel.photos.length,
                      photoPath: subOrderModel.photos[0].mobileUrl,
                    )
                  }
                ],
              ),
              if (subOrderModel.status == SubOrderStatus.onTheWay) ...{
                Divider(
                  color: context.colorScheme.waiting,
                  height: 0,
                  thickness: 2,
                ),
                SetOrderDeliveredButton(subOrderModel: subOrderModel)
              }
            ],
          ),
        ),
      ),
    );
  }
}
