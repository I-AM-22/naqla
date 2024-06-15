import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_blurhash/flutter_blurhash.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/enums/change_order_status.dart';
import 'package:naqla/core/common/enums/sub_order_status.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/di/di_container.dart';
import 'package:naqla/core/global_widgets/image_place_holder.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/usecases/set_arrived_use_case.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';

import '../../../../core/util/core_helper_functions.dart';
import '../../../../generated/l10n.dart';

class SubOrderCard extends StatelessWidget {
  const SubOrderCard({super.key, required this.orderModel});
  final SubOrderModel orderModel;

  @override
  Widget build(BuildContext context) {
    return BlocProvider.value(
      value: getIt<OrderBloc>(),
      child: Container(
        clipBehavior: Clip.antiAliasWithSaveLayer,
        decoration: BoxDecoration(border: Border.all(color: context.colorScheme.primary), borderRadius: BorderRadius.circular(8)),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  AppText.bodySmMedium(CoreHelperFunctions.formatOrderTime(context, orderModel.status,
                      acceptedAt: orderModel.acceptedAt,
                      arrivedAt: orderModel.arrivedAt,
                      deliveredAt: orderModel.deliveredAt,
                      driverAssignedAt: orderModel.driverAssignedAt,
                      pickedUpAt: orderModel.pickedUpAt)),
                  10.verticalSpace,
                  AppText.bodySmMedium(S.of(context).order_status),
                  2.verticalSpace,
                  AppText.bodySmMedium(orderModel.status.name),
                  10.verticalSpace,
                  AppText.bodySmMedium(S.of(context).cost),
                  2.verticalSpace,
                  AppText.bodySmMedium('${orderModel.cost} ${S.of(context).syp}'),
                  if (orderModel.status == SubOrderStatus.taken) ...{
                    10.verticalSpace,
                    BlocSelector<OrderBloc, OrderState, CommonState>(
                      selector: (state) => state.getState(OrderState.setArrived),
                      builder: (context, state) {
                        return AppButton.light(
                          isLoading: state.isLoading && context.read<OrderBloc>().state.subOrderId == orderModel.id,
                          buttonSize: ButtonSize.medium,
                          title: CoreHelperFunctions.getTitleButton(context,
                              arrivedAt: orderModel.arrivedAt, driverAssignedAt: orderModel.driverAssignedAt),
                          textStyle: TextStyle(fontSize: 13.sp, height: .2),
                          onPressed: () {
                            if (orderModel.arrivedAt != null) {
                              context
                                  .read<OrderBloc>()
                                  .add(ChangeOrderStatusEvent(param: SetArrivedParam(id: orderModel.id), status: ChangeOrderStatus.pickedUp));
                            } else if (orderModel.driverAssignedAt != null) {
                              context
                                  .read<OrderBloc>()
                                  .add(ChangeOrderStatusEvent(param: SetArrivedParam(id: orderModel.id), status: ChangeOrderStatus.arrived));
                            }
                          },
                        );
                      },
                    )
                  }
                ],
              ),
            ),
            // const Spacer(),
            if (orderModel.photos.isNotEmpty)
              Stack(
                children: [
                  SizedBox(
                      height: 200.h,
                      width: 150.w,
                      child: BlurHash(
                        imageFit: BoxFit.cover,
                        hash: orderModel.photos[0].blurHash,
                        image: orderModel.photos[0].mobileUrl,
                        errorBuilder: (context, error, stackTrace) {
                          return ImagePlaceHolder(width: 150.w, height: 150.h);
                        },
                      )),
                  if (orderModel.photos.length > 1)
                    Container(
                      color: context.colorScheme.primary.withOpacity(.5),
                      child: SizedBox(
                        width: 150.w,
                        height: 150.w,
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
      ),
    );
  }
}
