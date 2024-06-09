part of 'home_bloc.dart';

class HomeState extends StateObject<HomeState> {
  static String addCar = "addCar";
  static String carAdvantage = "carAdvantage";
  HomeState({States? states})
      : super([
          InitialState<CarModel>(addCar),
          InitialState<List<CarAdvantage>>(carAdvantage),
        ], (states) => HomeState(states: states), states);
}
