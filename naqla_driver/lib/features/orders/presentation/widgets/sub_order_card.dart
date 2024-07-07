import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/common/enums/order_status.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/app/presentation/widgets/app_loading_indicator.dart';
import 'package:naqla_driver/features/orders/domain/usecases/set_delivered_use_case.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';

import '../../../../core/common/constants/constants.dart';
import '../../../../generated/l10n.dart';
import '../../../home/data/model/sub_order_model.dart';

class SubOrderCard extends StatelessWidget {
  SubOrderCard({super.key, required this.subOrderModel});
  final SubOrderModel subOrderModel;

  List<String> orderId = [];

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: UIConstants.screenPadding16),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(8),
          boxShadow: [BoxShadow(color: context.colorScheme.primary.withOpacity(.2), blurRadius: 5, offset: Offset(0, 2))],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              clipBehavior: Clip.antiAlias,
              decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.primary),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Row(
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
                          TextSpan(text: '${S.of(context).order_status}: ${subOrderModel.status?.name}\n'),
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
                    Stack(
                      children: [
                        SizedBox(height: 150.h, width: 150.w, child: Center(child: AppImage.network(subOrderModel.photos[0].mobileUrl))),
                        if (subOrderModel.photos.length > 1)
                          Container(
                            width: 150.w,
                            height: 150.h,
                            color: context.colorScheme.primary.withOpacity(.5),
                            child: Center(
                                child: AppText.titleMedium(
                              '+${subOrderModel.photos.length - 1}',
                              color: Colors.white,
                            )),
                          ),
                      ],
                    )
                  }
                ],
              ),
            ),
            if (subOrderModel.status == SubOrderStatus.onTheWay)
              GestureDetector(
                behavior: HitTestBehavior.opaque,
                onTap: () {
                  orderId.add(subOrderModel.id);
                  context.read<OrderBloc>().add(SetDeliveredEvent(
                        param: SetDeliveredParam(id: subOrderModel.id),
                        onSuccess: () {
                          orderId.remove(subOrderModel.id);
                        },
                        onFailure: () {
                          orderId.remove(subOrderModel.id);
                        },
                      ));
                },
                child: Container(
                  padding: REdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                    borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                    border: Border.all(color: context.colorScheme.outline),
                    color: context.colorScheme.primary,
                  ),
                  child: Center(
                    child: BlocSelector<OrderBloc, OrderState, CommonState>(
                      selector: (state) => state.getState(OrderState.setDelivered),
                      builder: (context, state) {
                        if (state.isLoading && orderId.contains(subOrderModel.id)) {
                          return const AppLoadingIndicator(
                            color: Colors.white,
                            size: 35,
                          );
                        } else {
                          return AppText.subHeadMedium(
                            S.of(context).delivered,
                            color: Colors.white,
                          );
                        }
                      },
                    ),
                  ),
                ),
              )
          ],
        ),
      ),
    );
  }
}
