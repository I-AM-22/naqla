import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/features/cars/data/model/car_model.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/set_driver_use_case.dart';

import '../../../../core/use_case/use_case.dart';
import '../../domain/usecase/get_order_car_use_case.dart';
import '../../domain/usecase/get_sub_orders_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final GetSubOrdersUseCase getSubOrdersUseCase;
  final SetDriverUseCase setDriverUseCase;
  final GetOrderCarUseCase getOrderCarUseCase;
  HomeBloc(this.getSubOrdersUseCase, this.setDriverUseCase, this.getOrderCarUseCase) : super(HomeState()) {
    multiStateApiCall<SetDriverEvent, bool>(
      HomeState.setDriver,
      (event) => setDriverUseCase(event.param),
      onFailure: (failure, event, emit) async {
        print(failure.toString());
        print('failure.toString()');
      },
      onSuccess: (data, event, emit) async {
        final oldData = (state.getState<List<SubOrderModel>>(HomeState.subOrders).data ?? [])
          ..removeWhere(
            (element) => element.id == event.param.id,
          );

        if (oldData.isEmpty) {
          emit(state.updateState(HomeState.subOrders, const EmptyState<List<SubOrderModel>>()));
        } else {
          emit(state.updateData<List<SubOrderModel>>(HomeState.subOrders, oldData));
        }
        event.onSuccess();
      },
    );

    multiStateApiCall<GetSubOrdersEvent, List<SubOrderModel>>(HomeState.subOrders, (event) => getSubOrdersUseCase(NoParams()));

    multiStateApiCall<GetOrderCarEvent, List<CarModel>>(HomeState.orderCars, (event) => getOrderCarUseCase(event.id));
  }
}
