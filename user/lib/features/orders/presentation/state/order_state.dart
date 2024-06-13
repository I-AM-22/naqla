part of 'order_bloc.dart';

class OrderState extends StateObject<OrderState> {
  static String getOrders = "getOrders";
  static String getSubOrders = "getSubOrders";
  OrderState({States? states})
      : super([
          InitialState<List<OrderModel>>(getOrders),
          InitialState<List<SubOrderModel>>(getSubOrders),
        ], (states) => OrderState(states: states), states);
}
