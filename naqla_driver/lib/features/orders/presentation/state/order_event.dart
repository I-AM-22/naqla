part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetOrdersDoneEvent extends OrderEvent {}

class GetActiveOrdersEvent extends OrderEvent {}

class SetDeliveredEvent extends OrderEvent {
  final SetDeliveredParam param;
  final VoidCallback onSuccess;
  final VoidCallback onFailure;

  SetDeliveredEvent({required this.param, required this.onSuccess, required this.onFailure});
}

class GetSubOrderDetailsEvent extends OrderEvent {
  final String id;

  GetSubOrderDetailsEvent({required this.id});
}
