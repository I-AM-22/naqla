part of 'home_bloc.dart';

class HomeState extends StateObject<HomeState> {
  static String addCar = "addCar";
  static String carAdvantage = "carAdvantage";
  static String subOrders = "subOrders";
  HomeState({States? states})
      : super([
          InitialState<CarModel>(addCar),
          InitialState<List<CarAdvantage>>(carAdvantage),
          InitialState<List<SubOrderModel>>(subOrders),
        ], (states) => HomeState(states: states), states);
}
