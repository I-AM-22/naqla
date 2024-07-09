part of 'order_bloc.dart';

class OrderState extends StateObject<OrderState> {
  static String getActiveOrders = "getActiveOrders";
  static String getDoneOrders = "getDoneOrders";
  static String getSubOrders = "getSubOrders";
  static String setArrived = "setArrived";
  static String getSuOrderDetails = "getSuOrderDetails";

  OrderState({States? states})
      : super([
          InitialState<List<OrderModel>>(getActiveOrders),
          InitialState<List<OrderModel>>(getDoneOrders),
          InitialState<List<SubOrderModel>>(getSubOrders),
          InitialState<SubOrderModel>(setArrived),
          InitialState<SubOrderModel>(getSuOrderDetails),
        ], (states) => OrderState(states: states), states);
}
