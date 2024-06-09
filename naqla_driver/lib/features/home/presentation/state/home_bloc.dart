import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/features/home/data/model/car_advantage.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';
import 'package:naqla_driver/features/home/domain/usecase/add_car_use_case.dart';

import '../../../../core/use_case/use_case.dart';
import '../../domain/usecase/car_advantage_use_case.dart';

part 'home_event.dart';
part 'home_state.dart';

@injectable
class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final AddCarUseCase addCarUseCase;
  final CarAdvantageUseCase carAdvantageUseCase;
  HomeBloc(this.addCarUseCase, this.carAdvantageUseCase) : super(HomeState()) {
    multiStateApiCall<AddCarEvent, CarModel>(
      HomeState.addCar,
      (event) => addCarUseCase(event.param),
      onSuccess: (data, event, emit) async => event.onSuccess(),
    );

    multiStateApiCall<GetCarAdvantageEvent, List<CarAdvantage>>(HomeState.carAdvantage, (event) => carAdvantageUseCase(NoParams()));

    on<ChangeSelectAdvantageEvent>(
      (event, emit) {
        final List<CarAdvantage> oldData = state.getState(HomeState.carAdvantage).data;
        emit(state.updateData<List<CarAdvantage>>(HomeState.carAdvantage,
            oldData.map((element) => element == event.carAdvantage ? element.copyWith(isSelect: !element.isSelect) : element).toList()));
      },
    );
  }
}
