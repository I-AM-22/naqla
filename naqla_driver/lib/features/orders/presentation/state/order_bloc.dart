import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';

import '../../domain/usecases/get_orders_done_use_case.dart';

part 'order_state.dart';
part 'order_event.dart';

@injectable
class OrderBloc extends Bloc<OrderEvent, OrderState> {
  final GetOrdersDoneUseCase getOrdersDoneUseCase;
  OrderBloc(this.getOrdersDoneUseCase) : super(OrderState()) {
    multiStateApiCall<GetOrdersDoneEvent, List<SubOrderModel>>(
      OrderState.ordersDone,
      (event) => getOrdersDoneUseCase(NoParams()),
    );
  }
}
