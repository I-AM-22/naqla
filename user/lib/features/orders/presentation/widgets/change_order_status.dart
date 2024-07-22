import 'package:common_state/common_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:naqla/core/common/enums/change_order_status.dart';
import 'package:naqla/core/common/enums/sub_order_status.dart';
import 'package:naqla/core/core.dart';
import 'package:naqla/core/util/core_helper_functions.dart';
import 'package:naqla/features/app/presentation/widgets/app_loading_indicator.dart';
import 'package:naqla/features/orders/domain/usecases/set_arrived_use_case.dart';
import 'package:naqla/features/orders/presentation/state/order_bloc.dart';

// ignore: must_be_immutable
class ChangeOrderStatusWidget extends StatelessWidget {
  ChangeOrderStatusWidget({super.key, required this.orderId, required this.status, required this.index, this.arrivedAt, this.driverAssignedAt});
  final String orderId;
  final SubOrderStatus status;
  final DateTime? arrivedAt;
  final DateTime? driverAssignedAt;
  final int index;

  List<String> listOrderId = [];

  @override
  Widget build(BuildContext context) {
    return BlocSelector<OrderBloc, OrderState, CommonState>(
      selector: (state) => state.getState(OrderState.setArrived),
      builder: (context, state) {
        return Container(
          height: 40.h,
          width: double.infinity,
          color: context.colorScheme.primary,
          child: state.isLoading && listOrderId.contains(orderId)
              ? Center(
                  child: AppLoadingIndicator(
                    size: 25.r,
                    color: Colors.white,
                  ),
                )
              : InkWell(
                  onTap: () {
                    listOrderId.add(orderId);
                    if (arrivedAt != null) {
                      context.read<OrderBloc>().add(ChangeOrderStatusEvent(
                            param: SetArrivedParam(id: orderId),
                            status: ChangeOrderStatus.pickedUp,
                            index: index,
                            onSuccess: () {
                              listOrderId.remove(orderId);
                            },
                            onFailure: () {
                              listOrderId.remove(orderId);
                            },
                          ));
                    } else if (driverAssignedAt != null) {
                      context.read<OrderBloc>().add(ChangeOrderStatusEvent(
                            param: SetArrivedParam(id: orderId),
                            status: ChangeOrderStatus.arrived,
                            index: index,
                            onSuccess: () {
                              listOrderId.remove(orderId);
                            },
                            onFailure: () {
                              listOrderId.remove(orderId);
                            },
                          ));
                    }
                  },
                  child: Center(
                    child: AppText.subHeadMedium(
                      CoreHelperFunctions.getTitleButton(context, arrivedAt: arrivedAt, driverAssignedAt: driverAssignedAt),
                      color: Colors.white,
                      style: TextStyle(fontSize: 13.sp, height: .2),
                    ),
                  ),
                ),
        );
      },
    );
  }
}
