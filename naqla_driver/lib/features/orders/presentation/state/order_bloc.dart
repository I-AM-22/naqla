import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/orders/domain/usecases/get_sub_order_details.dart';
import 'package:naqla_driver/features/orders/domain/usecases/set_delivered_use_case.dart';

import '../../../home/data/model/sub_order_model.dart';
import '../../domain/usecases/get_orders_done_use_case.dart';
import '../../domain/usecases/get_orders_use_case.dart';

part 'order_state.dart';
part 'order_event.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersDoneUseCase getOrdersDoneUseCase;
  final GetOrdersUseCase getOrdersUseCase;
  final SetDeliveredUseCase setDeliveredUseCase;
  final GetSubOrderDetailsUseCase getSubOrderDetailsUseCase;
  OrderBloc(this.getOrdersDoneUseCase, this.getOrdersUseCase, this.setDeliveredUseCase, this.getSubOrderDetailsUseCase) : super(OrderState()) {
    multiStateApiCall<GetOrdersDoneEvent, List<SubOrderModel>>(
      OrderState.ordersDone,
      (event) => getOrdersDoneUseCase(NoParams()),
    );

    multiStateApiCall<GetOrdersEvent, List<SubOrderModel>>(
      OrderState.getOrders,
      (event) => getOrdersUseCase(NoParams()),
    );

    multiStateApiCall<GetSubOrderDetailsEvent, SubOrderModel>(
      OrderState.getSuOrderDetails,
      (event) => getSubOrderDetailsUseCase(event.id),
    );

    multiStateApiCall<SetDeliveredEvent, SubOrderModel>(
      OrderState.setDelivered,
      (event) => setDeliveredUseCase(event.param),
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<List<SubOrderModel>>(OrderState.getOrders).data ?? [];
        oldData.removeWhere(
          (element) => element.id == event.param.id,
        );
        emit(state.updateData(OrderState.getOrders, oldData));
        event.onSuccess();
      },
    );
  }
}
