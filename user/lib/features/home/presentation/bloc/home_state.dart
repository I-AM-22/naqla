part of 'home_bloc.dart';

class HomeState extends StateObject<HomeState> {
  static String changeLocationEvent = "changeLocationEvent";
  static String uploadPhotos = "uploadPhotos";
  static String carAdvantage = "carAdvantage";
  static String ordersActive = "ordersActive";

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
