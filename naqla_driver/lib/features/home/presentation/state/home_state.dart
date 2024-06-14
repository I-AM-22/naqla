part of 'home_bloc.dart';

class HomeState extends StateObject<HomeState> {

  static String subOrders = "subOrders";
  static String getAllCars = "getAllCars";
  static String setDriver = "setDriver";

  HomeState({States? states})
      : super([

          InitialState<List<SubOrderModel>>(subOrders),
          InitialState<List<CarModel>>(getAllCars),
          InitialState<void>(setDriver),
        ], (states) => HomeState(states: states), states);
}
