part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetActiveOrdersEvent extends OrderEvent {}

class GetDoneOrdersEvent extends OrderEvent {}

class GetSubOrdersEvent extends OrderEvent {
  final GetSubOrdersParam param;

  GetSubOrdersEvent({required this.param});
}

class ChangeOrderStatusEvent extends OrderEvent {
  final SetArrivedParam param;
  final ChangeOrderStatus status;
  final VoidCallback onSuccess;
  final VoidCallback onFailure;
  final int index;

  ChangeOrderStatusEvent({required this.param, required this.status, required this.onSuccess, required this.index, required this.onFailure});
}

class GetSubOrderDetailsEvent extends OrderEvent {
  final String id;

  GetSubOrderDetailsEvent({required this.id});
}

class RatingEvent extends OrderEvent {
  final RatingParam param;
  final VoidCallback onSuccess;

  RatingEvent({required this.param, required this.onSuccess});
}
