part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetOrdersEvent extends OrderEvent {}

class GetSubOrdersEvent extends OrderEvent {
  final GetSubOrdersParam param;

  GetSubOrdersEvent({required this.param});
}

class ChangeOrderStatusEvent extends OrderEvent {
  final SetArrivedParam param;
  final ChangeOrderStatus status;

  ChangeOrderStatusEvent({required this.param, required this.status});
}

class GetSubOrderDetailsEvent extends OrderEvent {
  final String id;

  GetSubOrderDetailsEvent({required this.id});
}
