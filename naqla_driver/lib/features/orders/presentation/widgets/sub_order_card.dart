import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla_driver/core/common/enums/order_status.dart';
import 'package:naqla_driver/core/core.dart';
import 'package:naqla_driver/core/util/core_helper_functions.dart';
import 'package:naqla_driver/features/orders/domain/usecases/set_delivered_use_case.dart';
import 'package:naqla_driver/features/orders/presentation/state/order_bloc.dart';

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
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            clipBehavior: Clip.antiAlias,
            height: 200.h,
            decoration: BoxDecoration(
                border: Border.all(color: context.colorScheme.primary),
                borderRadius: const BorderRadius.only(topRight: Radius.circular(8), topLeft: Radius.circular(8))),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Flexible(
                          child: AppText.bodySmMedium(
                        '${S.of(context).weight}${subOrderModel.weight}',
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      )),
                      10.verticalSpace,
                      Flexible(child: AppText.bodySmMedium('${S.of(context).cost}${formatter.format(subOrderModel.cost)}')),
                      10.verticalSpace,
                      Flexible(child: AppText.bodySmMedium('${S.of(context).order_status}: ${subOrderModel.status?.name}')),
                      10.verticalSpace,
                      Flexible(
                          child: AppText.bodySmMedium(CoreHelperFunctions.formatOrderTime(context, subOrderModel.status!,
                              pickedUpAt: subOrderModel.pickedUpAt,
                              driverAssignedAt: subOrderModel.driverAssignedAt,
                              arrivedAt: subOrderModel.arrivedAt,
                              acceptedAt: subOrderModel.acceptedAt,
                              deliveredAt: subOrderModel.deliveredAt))),
                    ],
                  ),
                ),
                if (subOrderModel.photos.isNotEmpty) ...{
                  Stack(
                    children: [
                      SizedBox(
                          height: 200.h,
                          width: 150.w,
                          child: BlurHash(imageFit: BoxFit.cover, hash: subOrderModel.photos[0].blurHash, image: subOrderModel.photos[0].mobileUrl)),
                      if (subOrderModel.photos.length > 1)
                        Container(
                          color: context.colorScheme.primary.withOpacity(.5),
                          child: SizedBox(
                            width: 150.w,
                            height: 150.w,
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
          if (subOrderModel.status == SubOrderStatus.onTheWay)
            Container(
              decoration: BoxDecoration(
                borderRadius: const BorderRadius.only(bottomRight: Radius.circular(8), bottomLeft: Radius.circular(8)),
                border: Border.all(color: context.colorScheme.outline),
                color: context.colorScheme.primary,
              ),
              child: Center(
                child: BlocSelector<OrderBloc, OrderState, CommonState>(
                  selector: (state) => state.getState(OrderState.setDelivered),
                  builder: (context, state) {
                    return AppButton.ghost(
                      title: S.of(context).set_order_delivered,
                      isLoading: state.isLoading,
                      onPressed: () {
                        context.read<OrderBloc>().add(SetDeliveredEvent(
                              param: SetDeliveredParam(id: subOrderModel.id),
                              onSuccess: () {},
                            ));
                      },
                    );
                  },
                ),
              ),
            )
        ],
      ),
    );
  }
}
