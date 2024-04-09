part of 'home_bloc.dart';

class HomeState extends StateObject<HomeState> {
  static String changeLocationEvent = "changeLocationEvent";
  static String uploadPhotos = "changeLocationEvent";
  static String carAdvantage = "changeLocationEvent";
  static String ordersActive = "changeLocationEvent";

  HomeState([States? states])
      : super(
          [
            InitialState<LocationData?>(changeLocationEvent),
            InitialState<List<String>>(uploadPhotos),
            InitialState<List<CarAdvantage>>(carAdvantage),
            InitialState<List<OrderModel>>(ordersActive),
          ],
          (states) => HomeState(states),
          states,
        );
}
