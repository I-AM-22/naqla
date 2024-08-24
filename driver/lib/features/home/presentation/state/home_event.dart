part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class GetSubOrdersEvent extends HomeEvent {}

class SetDriverEvent extends HomeEvent {
  final SetDriverParam param;
  final VoidCallback onSuccess;

  SetDriverEvent({required this.param, required this.onSuccess});
}

class GetOrderCarEvent extends HomeEvent {
  final String id;

  GetOrderCarEvent({required this.id});
}
