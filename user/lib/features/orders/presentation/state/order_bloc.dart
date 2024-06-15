import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/usecases/set_arrived_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/set_picked_up_use_case.dart';

import '../../../../core/common/enums/change_order_status.dart';
import '../../domain/usecases/get_orders_use_case.dart';
import '../../domain/usecases/get_sub_order_details_use_case.dart';
import '../../domain/usecases/get_sub_orders_use_case.dart';

part 'order_event.dart';
part 'order_state.dart';

@lazySingleton
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersUseCase getOrdersUseCase;
  final GetSubOrdersUseCase getSubOrdersUseCase;
  final SetArrivedUseCase setArrivedUseCase;
  final SetPickedUpUseCase setPickedUpUseCase;
  final GetSubOrderDetailsUseCase getSubOrderDetailsUseCase;
  OrderBloc(this.getOrdersUseCase, this.getSubOrdersUseCase, this.setArrivedUseCase, this.setPickedUpUseCase, this.getSubOrderDetailsUseCase)
      : super(OrderState()) {
    multiStateApiCall<GetOrdersEvent, List<OrderModel>>(OrderState.getOrders, (event) => getOrdersUseCase(NoParams()));

    multiStateApiCall<GetSubOrdersEvent, List<SubOrderModel>>(OrderState.getSubOrders, (event) => getSubOrdersUseCase(event.param));

    multiStateApiCall<ChangeOrderStatusEvent, SubOrderModel>(
      OrderState.setArrived,
      (event) {
        if (event.status == ChangeOrderStatus.arrived) {
          return setArrivedUseCase(event.param);
        } else {
          return setPickedUpUseCase(event.param);
        }
      },
      preCall: (event, emit) async {
        emit(state.copyWith(subOrderId: event.param.id));
      },
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<List<SubOrderModel>>(OrderState.getSubOrders).data ?? [];
        oldData.removeWhere(
          (element) => event.param.id == element.id,
        );
        oldData.add(data);
        emit(state.updateData(OrderState.getSubOrders, oldData));
      },
    );

    multiStateApiCall<GetSubOrderDetailsEvent, SubOrderModel>(
      OrderState.getSuOrderDetails,
      (event) => getSubOrderDetailsUseCase(event.id),
    );
  }
}
