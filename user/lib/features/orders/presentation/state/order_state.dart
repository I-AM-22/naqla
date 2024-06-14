part of 'order_bloc.dart';

class OrderState extends StateObject<OrderState> {
  static String getOrders = "getOrders";
  static String getSubOrders = "getSubOrders";
  static String setArrived = "setArrived";
  OrderState({States? states})
      : super([
          InitialState<List<OrderModel>>(getOrders),
          InitialState<List<SubOrderModel>>(getSubOrders),
          InitialState<SubOrderModel>(setArrived),
        ], (states) => OrderState(states: states), states);
}
