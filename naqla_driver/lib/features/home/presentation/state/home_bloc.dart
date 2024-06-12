import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/di/di_container.dart';
import 'package:naqla_driver/features/app/presentation/state/bloc/app_bloc.dart';
import 'package:naqla_driver/features/home/data/model/car_advantage.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';
import 'package:naqla_driver/features/home/data/model/sub_order_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';
import 'package:naqla_driver/features/home/domain/usecase/set_driver_use_case.dart';

import '../../../../core/use_case/use_case.dart';
import '../../../app/domain/usecases/get_all_cars_use_case.dart';
import '../../domain/usecase/car_advantage_use_case.dart';
import '../../domain/usecase/get_sub_orders_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

@lazySingleton
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AddCarUseCase addCarUseCase;
  final CarAdvantageUseCase carAdvantageUseCase;
  final GetSubOrdersUseCase getSubOrdersUseCase;
  final GetAllCarsUseCase getAllCarsUseCase;
  final SetDriverUseCase setDriverUseCase;
  HomeBloc(this.addCarUseCase, this.carAdvantageUseCase, this.getSubOrdersUseCase, this.getAllCarsUseCase, this.setDriverUseCase)
      : super(HomeState()) {
    multiStateApiCall<AddCarEvent, CarModel>(
      HomeState.addCar,
      (event) => addCarUseCase(event.param),
      onSuccess: (data, event, emit) async => event.onSuccess(),
    );

    multiStateApiCall<GetAllCarsEvent, List<CarModel>>(
      AppState.getAllCars,
      (event) => getAllCarsUseCase(NoParams()),
    );

    multiStateApiCall<SetDriverEvent, void>(
      HomeState.setDriver,
      (event) => setDriverUseCase(event.param),
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

    multiStateApiCall<GetCarAdvantageEvent, List<CarAdvantage>>(HomeState.carAdvantage, (event) => carAdvantageUseCase(NoParams()));

    multiStateApiCall<GetSubOrdersEvent, List<SubOrderModel>>(HomeState.subOrders, (event) => getSubOrdersUseCase(NoParams()));

    on<ChangeSelectAdvantageEvent>(
      (event, emit) {
        final List<CarAdvantage> oldData = state.getState(HomeState.carAdvantage).data;
        emit(state.updateData<List<CarAdvantage>>(HomeState.carAdvantage,
            oldData.map((element) => element == event.carAdvantage ? element.copyWith(isSelect: !element.isSelect) : element).toList()));
      },
    );
  }
}
