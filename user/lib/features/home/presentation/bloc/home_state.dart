part of 'home_bloc.dart';

class HomeState extends StateObject<HomeState> {
  static String changeLocationEvent = "changeLocationEvent";
  static String uploadPhotos = "uploadPhotos";
  static String carAdvantage = "carAdvantage";
  static String ordersActive = "ordersActive";
  static String setOrder = "setOrder";
  static String acceptOrder = "acceptOrder";
  static String cancelOrder = "cancelOrder";

  final SetOrderParam setOrderParam;
  final int formCount;

  HomeState({States? states, SetOrderParam? setOrderParam, int? formCount})
      : setOrderParam = setOrderParam ?? SetOrderParam.empty(),
        formCount = formCount ?? 1,
        super(
          [
            InitialState<LocationData?>(changeLocationEvent),
            InitialState<List<String>>(uploadPhotos),
            InitialState<List<CarAdvantage>>(carAdvantage),
            InitialState<List<OrderModel>>(ordersActive),
            InitialState<OrderModel>(setOrder),
            InitialState<OrderModel>(acceptOrder),
            InitialState<OrderModel>(cancelOrder),
          ],
          (states) => HomeState(states: states, setOrderParam: setOrderParam, formCount: formCount),
          states,
        );

  HomeState copyWith({SetOrderParam? setOrderParam, int? formCount}) =>
      HomeState(setOrderParam: setOrderParam ?? this.setOrderParam, states: states, formCount: formCount ?? this.formCount);

  @override
  List<Object?> get props => [states, setOrderParam, formCount];
}
