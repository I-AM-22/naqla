import 'dart:ui';

import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

import '../../../../core/use_case/use_case.dart';
import '../../data/model/car_advantage.dart';
import '../../domain/usecases/add_car_use_case.dart';
import '../../../home/domain/usecase/car_advantage_use_case.dart';
import '../../data/model/car_model.dart';
import '../../domain/usecases/delete_car_use_case.dart';
import '../../domain/usecases/edit_car_use_case.dart';
import '../../domain/usecases/get_all_cars_use_case.dart';
import 'package:collection/collection.dart';

part 'cars_event.dart';
part 'cars_state.dart';

@injectable
class CarsBloc extends Bloc<CarsEvent, CarsState> {
  final GetAllCarsUseCase getAllCarsUseCase;
  final DeleteCarUseCase deleteCarUseCase;
  final EditCarUseCase editCarUseCase;
  final AddCarUseCase addCarUseCase;
  final CarAdvantageUseCase carAdvantageUseCase;
  CarsBloc(this.getAllCarsUseCase, this.deleteCarUseCase, this.editCarUseCase, this.addCarUseCase, this.carAdvantageUseCase) : super(CarsState()) {
    multiStateApiCall<GetAllCarsEvent, List<CarModel>>(
      CarsState.getAllCars,
      (event) => getAllCarsUseCase(NoParams()),
    );

    multiStateApiCall<DeleteCarEvent, void>(
      CarsState.deleteCar,
      (event) => deleteCarUseCase(event.id),
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<List<CarModel>>(CarsState.getAllCars).data ?? [];
        oldData.removeWhere(
          (element) => element.id == event.id,
        );
        if (oldData.isEmpty) {
          emit(state.updateState(CarsState.getAllCars, const EmptyState<List<CarModel>>()));
        } else {
          emit(state.updateData(CarsState.getAllCars, oldData));
        }
        event.onSuccess();
      },
    );

    multiStateApiCall<EditCarEvent, CarModel>(
      CarsState.editCar,
      (event) => editCarUseCase(event.param),
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<List<CarModel>>(CarsState.getAllCars).data ?? [];
        oldData.removeWhere(
          (element) => element.id == event.param.id,
        );
        oldData.add(data);
        emit(state.updateData(CarsState.getAllCars, oldData));
        event.onSuccess();
      },
    );

    multiStateApiCall<AddCarEvent, CarModel>(
      CarsState.addCar,
      (event) => addCarUseCase(event.param),
      onSuccess: (data, event, emit) async {
        final oldData = state.getState<List<CarModel>>(CarsState.getAllCars);
        if (oldData.isSuccess) {
          oldData.data?.add(data);
          emit(state.updateData<List<CarModel>>(CarsState.getAllCars, oldData.data ?? []));
        } else {
          emit(state.updateState(CarsState.getAllCars, SuccessState<List<CarModel>>([data])));
        }
        event.onSuccess();
      },
    );

    on<ChangeSelectAdvantageEvent>(
      (event, emit) {
        final List<CarAdvantage> oldData = state.getState(CarsState.carAdvantage).data;
        emit(state.updateData<List<CarAdvantage>>(CarsState.carAdvantage,
            oldData.map((element) => element == event.carAdvantage ? element.copyWith(isSelect: !element.isSelect) : element).toList()));
      },
    );

    multiStateApiCall<GetCarAdvantageEvent, List<CarAdvantage>>(
      CarsState.carAdvantage,
      (event) => carAdvantageUseCase(NoParams()),
      onSuccess: (data, event, emit) async {
        if (event.advantages != null) {
          event.advantages?.forEach(
            (e) {
              final advantage = data.firstWhereOrNull(
                (element) {
                  return e.id == element.id;
                },
              );
              if (advantage != null) {
                data.remove(advantage);
                data.add(advantage.copyWith(isSelect: true));
              }
            },
          );
          emit(state.updateData<List<CarAdvantage>>(CarsState.carAdvantage, data));
        }
      },
    );
  }
}
