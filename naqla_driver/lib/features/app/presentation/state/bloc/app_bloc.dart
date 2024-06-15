import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/app/domain/usecases/delete_car_use_case.dart';
import 'package:naqla_driver/features/app/domain/usecases/edit_car_use_case.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';

import '../../../../home/data/model/car_advantage.dart';
import '../../../../home/domain/usecase/car_advantage_use_case.dart';
import '../../../domain/usecases/get_all_cars_use_case.dart';

part 'app_event.dart';
part 'app_state.dart';

@injectable
class AppBloc extends Bloc<AppEvent, AppState> {
  final GetAllCarsUseCase getAllCarsUseCase;
  final DeleteCarUseCase deleteCarUseCase;
  final EditCarUseCase editCarUseCase;
  final AddCarUseCase addCarUseCase;
  final CarAdvantageUseCase carAdvantageUseCase;

  AppBloc(this.getAllCarsUseCase, this.deleteCarUseCase, this.editCarUseCase, this.addCarUseCase, this.carAdvantageUseCase) : super(AppState()) {
    multiStateApiCall<GetAllCarsEvent, List<CarModel>>(
      AppState.getAllCars,
      (event) => getAllCarsUseCase(NoParams()),
    );

    multiStateApiCall<DeleteCarEvent, void>(
      AppState.deleteCar,
      (event) => deleteCarUseCase(event.id),
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<List<CarModel>>(AppState.getAllCars).data ?? [];
        oldData.removeWhere(
          (element) => element.id == event.id,
        );
        if (oldData.isEmpty) {
          emit(state.updateState(AppState.getAllCars, const EmptyState<List<CarModel>>()));
        } else {
          emit(state.updateData(AppState.getAllCars, oldData));
        }
        event.onSuccess();
      },
    );

    multiStateApiCall<EditCarEvent, CarModel>(
      AppState.editCar,
      (event) => editCarUseCase(event.param),
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<List<CarModel>>(AppState.getAllCars).data ?? [];
        oldData.removeWhere(
          (element) => element.id == event.param.id,
        );
        oldData.add(data);
        emit(state.updateData(AppState.getAllCars, oldData));
        event.onSuccess();
      },
    );

    multiStateApiCall<GetCarAdvantageEvent, List<CarAdvantage>>(
      AppState.carAdvantage,
      (event) => carAdvantageUseCase(NoParams()),
    );

    on<ChangeSelectAdvantageEvent>(
      (event, emit) {
        final List<CarAdvantage> oldData = state.getState(AppState.carAdvantage).data;
        emit(state.updateData<List<CarAdvantage>>(AppState.carAdvantage,
            oldData.map((element) => element == event.carAdvantage ? element.copyWith(isSelect: !element.isSelect) : element).toList()));
      },
    );

    multiStateApiCall<AddCarEvent, CarModel>(
      AppState.addCar,
      (event) => addCarUseCase(event.param),
      onSuccess: (data, event, emit) async {
        add(GetAllCarsEvent());
        event.onSuccess();
      },
    );
  }
}
