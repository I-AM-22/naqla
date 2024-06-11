import 'package:common_state/common_state.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:naqla_driver/core/use_case/use_case.dart';
import 'package:naqla_driver/features/home/data/model/car_model.dart';

import '../../../domain/usecases/get_all_cars_use_case.dart';

part 'app_event.dart';
part 'app_state.dart';

@injectable
class AppBloc extends Bloc<AppEvent, AppState> {
  final GetAllCarsUseCase getAllCarsUseCase;
  AppBloc(this.getAllCarsUseCase) : super(AppState()) {
    multiStateApiCall(
      AppState.getAllCars,
      (event) => getAllCarsUseCase(NoParams()),
    );
  }
}
