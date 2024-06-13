part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetOrdersEvent extends OrderEvent {}

class GetSubOrdersEvent extends OrderEvent {
  final GetSubOrdersParam param;

  GetSubOrdersEvent({required this.param});
}
