part of 'home_bloc.dart';

class HomeState extends StateObject<HomeState> {
  static String addCar = "addCar";
  static String carAdvantage = "carAdvantage";
  static String subOrders = "subOrders";
  static String getAllCars = "getAllCars";
  static String setDriver = "setDriver";

  HomeState({States? states})
      : super([
          InitialState<CarModel>(addCar),
          InitialState<List<CarAdvantage>>(carAdvantage),
          InitialState<List<SubOrderModel>>(subOrders),
          InitialState<List<CarModel>>(getAllCars),
          InitialState<void>(setDriver),
        ], (states) => HomeState(states: states), states);
}
