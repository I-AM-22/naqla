part of 'order_bloc.dart';

class OrderState extends StateObject<OrderState> {
  static String ordersDone = "ordersDone";
  static String getOrders = "getOrders";
  OrderState({States? states})
      : super([
          InitialState<List<Sub2OrderModel>>(ordersDone),
          InitialState<List<Sub2OrderModel>>(getOrders),
        ], (states) => OrderState(states: states), states);
}
