part of 'order_bloc.dart';

class OrderState extends StateObject<OrderState> {
  static String ordersDone = "ordersDone";
  static String getOrders = "getOrders";
  static String setDelivered = "setDelivered";
  OrderState({States? states})
      : super([
          InitialState<List<Sub2OrderModel>>(ordersDone),
          InitialState<List<Sub2OrderModel>>(getOrders),
          InitialState<Sub2OrderModel>(setDelivered),
        ], (states) => OrderState(states: states), states);
}
