part of 'order_bloc.dart';

@immutable
sealed class OrderEvent {}

class GetOrdersDoneEvent extends OrderEvent {}

class GetOrdersEvent extends OrderEvent {}
