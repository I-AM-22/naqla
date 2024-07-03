part of 'order_bloc.dart';

class OrderState extends StateObject<OrderState> {
  static String getActiveOrders = "getActiveOrders";
  static String getDoneOrders = "getDoneOrders";
  static String getSubOrders = "getSubOrders";
  static String setArrived = "setArrived";
  static String getSuOrderDetails = "getSuOrderDetails";

  final String subOrderId;
  OrderState({States? states, String? subOrderId})
      : subOrderId = subOrderId ?? '',
        super([
          InitialState<List<OrderModel>>(getActiveOrders),
          InitialState<List<OrderModel>>(getDoneOrders),
          InitialState<List<SubOrderModel>>(getSubOrders),
          InitialState<SubOrderModel>(setArrived),
          InitialState<SubOrderModel>(getSuOrderDetails),
        ], (states) => OrderState(states: states, subOrderId: subOrderId), states);

  OrderState copyWith({String? subOrderId}) => OrderState(subOrderId: subOrderId ?? this.subOrderId, states: states);

  @override
  List<Object?> get props => super.props..addAll([subOrderId]);
}
