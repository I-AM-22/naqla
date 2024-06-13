import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla/core/use_case/use_case.dart';
import 'package:naqla/features/home/data/model/order_model.dart';
import 'package:naqla/features/orders/data/model/sub_order_model.dart';

import '../../domain/usecases/get_orders_use_case.dart';
import '../../domain/usecases/get_sub_orders_use_case.dart';

part 'order_event.dart';
part 'order_state.dart';

@lazySingleton
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersUseCase getOrdersUseCase;
  final GetSubOrdersUseCase getSubOrdersUseCase;
  OrderBloc(this.getOrdersUseCase, this.getSubOrdersUseCase) : super(OrderState()) {
    multiStateApiCall<GetOrdersEvent, List<OrderModel>>(OrderState.getOrders, (event) => getOrdersUseCase(NoParams()));

    multiStateApiCall<GetSubOrdersEvent, List<SubOrderModel>>(OrderState.getSubOrders, (event) => getSubOrdersUseCase(event.param));
  }
}
