part of 'order_bloc.dart';

class OrderState extends StateObject<OrderState> {
  static String ordersDone = "ordersDone";
  static String getOrders = "getOrders";
  static String setDelivered = "setDelivered";
  static String getSuOrderDetails = "getSuOrderDetails";
  OrderState({States? states})
      : super([
          InitialState<List<SubOrderModel>>(ordersDone),
          InitialState<List<SubOrderModel>>(getOrders),
          InitialState<SubOrderModel>(setDelivered),
          InitialState<SubOrderModel>(getSuOrderDetails),
        ], (states) => OrderState(states: states), states);
}
