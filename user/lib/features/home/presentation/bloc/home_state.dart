part of 'home_bloc.dart';

class HomeState extends StateObject<HomeState> {
  static String changeLocationEvent = "changeLocationEvent";
  static String uploadPhotos = "uploadPhotos";
  static String carAdvantage = "carAdvantage";
  static String ordersActive = "ordersActive";
  static String setOrder = "setOrder";

  final SetOrderParam setOrderParam;

  HomeState({States? states, SetOrderParam? setOrderParam})
      : setOrderParam = setOrderParam ?? SetOrderParam.empty(),
        super(
          [
            InitialState<LocationData?>(changeLocationEvent),
            InitialState<List<String>>(uploadPhotos),
            InitialState<List<CarAdvantage>>(carAdvantage),
            InitialState<List<OrderModel>>(ordersActive),
            InitialState<OrderModel>(setOrder),
          ],
          (states) => HomeState(states: states, setOrderParam: setOrderParam),
          states,
        );

  HomeState copyWith({SetOrderParam? setOrderParam}) =>
      HomeState(setOrderParam: setOrderParam ?? this.setOrderParam);

  @override
  List<Object?> get props => [states, setOrderParam];
}
