part of 'app_bloc.dart';

class AppState extends StateObject<AppState> {
  static String getAllCars = "getAllCars";
  AppState({States? states})
      : super([
          InitialState<List<CarModel>>(getAllCars),
        ], (states) => AppState(states: states), states);
}
