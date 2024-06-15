part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetOrdersDoneEvent extends OrderEvent {}

class GetOrdersEvent extends OrderEvent {}

class SetDeliveredEvent extends OrderEvent {
  final SetDeliveredParam param;
  final VoidCallback onSuccess;

  SetDeliveredEvent({required this.param, required this.onSuccess});
}

class GetSubOrderDetailsEvent extends OrderEvent {
  final String id;

  GetSubOrderDetailsEvent({required this.id});
}
