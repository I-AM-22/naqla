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
  final GetActiveOrdersUseCase getActiveOrdersUseCase;
  final SetDeliveredUseCase setDeliveredUseCase;
  final GetSubOrderDetailsUseCase getSubOrderDetailsUseCase;
  OrderBloc(this.getOrdersDoneUseCase, this.getActiveOrdersUseCase, this.setDeliveredUseCase, this.getSubOrderDetailsUseCase) : super(OrderState()) {
    multiStateApiCall<GetOrdersDoneEvent, List<SubOrderModel>>(
      OrderState.ordersDone,
      (event) => getOrdersDoneUseCase(NoParams()),
    );

    multiStateApiCall<GetActiveOrdersEvent, List<SubOrderModel>>(
      OrderState.getActiveOrders,
      (event) => getActiveOrdersUseCase(NoParams()),
    );

    multiStateApiCall<GetSubOrderDetailsEvent, SubOrderModel>(
      OrderState.getSuOrderDetails,
      (event) => getSubOrderDetailsUseCase(event.id),
    );

    multiStateApiCall<SetDeliveredEvent, SubOrderModel>(
      OrderState.setDelivered,
      (event) => setDeliveredUseCase(event.param),
      onFailure: (failure, event, emit) async => event.onFailure(),
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<List<SubOrderModel>>(OrderState.getActiveOrders).data ?? [];
        oldData.removeWhere(
          (element) => element.id == event.param.id,
        );
        if (oldData.isEmpty) {
          emit(state.updateState(OrderState.getActiveOrders, const EmptyState<List<SubOrderModel>>()));
        } else {
          emit(state.updateData<List<SubOrderModel>>(OrderState.getActiveOrders, oldData));
        }
        event.onSuccess();
      },
    );
  }
}
