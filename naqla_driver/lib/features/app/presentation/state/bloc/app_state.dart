part of 'app_bloc.dart';

class AppState extends StateObject<AppState> {
  static String getAllCars = "getAllCars";
  static String deleteCar = "deleteCar";
  static String editCar = "editCar";
  static String addCar = "addCar";
  static String carAdvantage = "carAdvantage";
  AppState({States? states})
      : super([
    InitialState<CarModel>(addCar),
    InitialState<List<CarAdvantage>>(carAdvantage),
          InitialState<List<CarModel>>(getAllCars),
          InitialState<void>(deleteCar),
          InitialState<CarModel>(editCar),
        ], (states) => AppState(states: states), states);
}
