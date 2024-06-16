import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
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

  String orderId = '';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: REdgeInsets.symmetric(vertical: 8, horizontal: UIConstants.screenPadding16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            padding: REdgeInsets.all(8),
            decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.primary),
                borderRadius: BorderRadius.only(
                    topRight: const Radius.circular(8),
                    topLeft: const Radius.circular(8),
                    bottomLeft: subOrderModel.status == SubOrderStatus.onTheWay ? Radius.zero : const Radius.circular(8),
                    bottomRight: subOrderModel.status == SubOrderStatus.onTheWay ? Radius.zero : const Radius.circular(8))),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  RichText(
                    text: TextSpan(style: context.textTheme.subHeadMedium.copyWith(color: context.colorScheme.primary), children: [
                      TextSpan(text: '${S.of(context).weight}${subOrderModel.weight},'),
                      WidgetSpan(child: 5.horizontalSpace),
                      TextSpan(text: '${S.of(context).cost}${formatter.format(subOrderModel.cost)} ${S.of(context).syp},'),
                      if ((subOrderModel.order?.porters ?? 0) > 0) ...{
                        WidgetSpan(child: 5.horizontalSpace),
                        TextSpan(text: '${S.of(context).the_number_of_floors}: ${(subOrderModel.order?.porters ?? 1) - 1},'),
                      },
                      WidgetSpan(child: 5.horizontalSpace),
                      TextSpan(text: '${S.of(context).order_status}: ${subOrderModel.status?.name}'),
                    ]),
                  ),
                  10.verticalSpace,
                  AppText.subHeadMedium(CoreHelperFunctions.formatOrderTime(context, subOrderModel.status!,
                      pickedUpAt: subOrderModel.pickedUpAt,
                      driverAssignedAt: subOrderModel.driverAssignedAt,
                      arrivedAt: subOrderModel.arrivedAt,
                      acceptedAt: subOrderModel.acceptedAt,
                      deliveredAt: subOrderModel.deliveredAt)),
                  if (subOrderModel.photos.isNotEmpty) ...{
                    10.verticalSpace,
                    Stack(
                      children: [
                        Container(
                            height: 200.h,
                            decoration: BoxDecoration(
                              border: Border.all(color: context.colorScheme.outline),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child:
                                BlurHash(imageFit: BoxFit.contain, hash: subOrderModel.photos[0].blurHash, image: subOrderModel.photos[0].mobileUrl)),
                        if (subOrderModel.photos.length > 1)
                          Container(
                            color: context.colorScheme.primary.withOpacity(.5),
                            child: SizedBox(
                              height: 200.h,
                              child: Center(
                                  child: AppText.titleMedium(
                                '+${subOrderModel.photos.length - 1}',
                                color: Colors.white,
                              )),
                            ),
                          ),
                      ],
                    )
                  }
                ],
              ),
            ),
          ),
          if (subOrderModel.status == SubOrderStatus.onTheWay)
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                orderId = subOrderModel.id;
                context.read<OrderBloc>().add(SetDeliveredEvent(
                      param: SetDeliveredParam(id: subOrderModel.id),
                      onSuccess: () {},
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
                      if (state.isLoading && orderId == subOrderModel.id) {
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
    );
  }
}
