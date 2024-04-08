part of 'home_bloc.dart';

class HomeState {
  static int changeLocationEvent = 0;
  static int uploadPhotos = 1;
  static int carAdvantage = 2;
  static int ordersActive = 3;

  static Map<int, CommonState> get iniState => {
        changeLocationEvent: const InitialState<LatLng>(),
        uploadPhotos: const InitialState<List<String>>(),
        carAdvantage: const InitialState<List<CarAdvantage>>(),
        ordersActive: const InitialState<List<OrderModel>>(),
      };
}
