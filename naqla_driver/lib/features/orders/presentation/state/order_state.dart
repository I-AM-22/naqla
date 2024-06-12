part of 'order_bloc.dart';

class OrderState extends StateObject<OrderState> {
  static String ordersDone = "ordersDone";
  OrderState({States? states})
      : super([
          InitialState<List<SubOrderModel>>(ordersDone),
        ], (states) => OrderState(states: states), states);
}
