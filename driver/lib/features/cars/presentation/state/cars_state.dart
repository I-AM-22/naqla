part of 'cars_bloc.dart';

class CarsState extends StateObject<CarsState> {
  static String getAllCars = "getAllCars";
  static String deleteCar = "deleteCar";
  static String editCar = "editCar";
  static String addCar = "addCar";
  static String carAdvantage = "carAdvantage";

  CarsState({States? states})
      : super([
          InitialState<CarModel>(addCar),
          InitialState<List<CarModel>>(getAllCars),
          InitialState<void>(deleteCar),
          InitialState<CarModel>(editCar),
          InitialState<List<CarAdvantage>>(carAdvantage),
        ], (states) => CarsState(states: states), states);
}
