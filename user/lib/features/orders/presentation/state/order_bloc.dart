import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';
import 'package:naqla/features/orders/domain/usecases/get_done_orders_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/rating_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/set_arrived_use_case.dart';
import 'package:naqla/features/orders/domain/usecases/set_picked_up_use_case.dart';

import '../../../../core/common/enums/change_order_status.dart';
import '../../domain/usecases/get_active_orders_use_case.dart';
import '../../domain/usecases/get_sub_order_details_use_case.dart';
import '../../domain/usecases/get_sub_orders_use_case.dart';

part 'order_event.dart';
part 'order_state.dart';

@lazySingleton
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetActiveOrdersUseCase getActiveOrdersUseCase;
  final GetDoneOrdersUseCase getDoneOrdersUseCase;
  final GetSubOrdersUseCase getSubOrdersUseCase;
  final SetArrivedUseCase setArrivedUseCase;
  final SetPickedUpUseCase setPickedUpUseCase;
  final RatingUseCase ratingUseCase;
  final GetSubOrderDetailsUseCase getSubOrderDetailsUseCase;
  OrderBloc(this.getActiveOrdersUseCase, this.getSubOrdersUseCase, this.setArrivedUseCase, this.setPickedUpUseCase, this.getSubOrderDetailsUseCase,
      this.getDoneOrdersUseCase, this.ratingUseCase)
      : super(OrderState()) {
    multiStateApiCall<GetActiveOrdersEvent, List<OrderModel>>(OrderState.getActiveOrders, (event) => getActiveOrdersUseCase(NoParams()));

    multiStateApiCall<GetDoneOrdersEvent, List<OrderModel>>(OrderState.getDoneOrders, (event) => getDoneOrdersUseCase(NoParams()));

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
      onSuccess: (data, event, emit) async {
        event.onSuccess();
        final oldData = state.getState<List<SubOrderModel>>(OrderState.getSubOrders).data ?? [];
        oldData.removeAt(event.index);
        oldData.insert(event.index, data);
        emit(state.updateData(OrderState.getSubOrders, oldData));
      },
      onFailure: (failure, event, emit) async {
        event.onFailure();
      },
    );

    multiStateApiCall<GetSubOrderDetailsEvent, SubOrderModel>(
      OrderState.getSuOrderDetails,
      (event) => getSubOrderDetailsUseCase(event.id),
    );

    multiStateApiCall<RatingEvent, SubOrderModel>(
      OrderState.rating,
      (event) => ratingUseCase(event.param),
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<SubOrderModel>(OrderState.getSuOrderDetails).data;
        emit(state.updateData<SubOrderModel>(OrderState.getSuOrderDetails, oldData!.copyWith(rating: event.param.rating, note: event.param.notes)));
        event.onSuccess();
      },
    );
  }
}
