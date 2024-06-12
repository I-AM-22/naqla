part of 'home_bloc.dart';

@immutable
sealed class HomeEvent {}

class AddCarEvent extends HomeEvent {
  final AddCarParam param;
  final VoidCallback onSuccess;

  AddCarEvent({required this.param, required this.onSuccess});
}

class ChangeSelectAdvantageEvent extends HomeEvent {
  final CarAdvantage carAdvantage;

  ChangeSelectAdvantageEvent({required this.carAdvantage});
}

class GetCarAdvantageEvent extends HomeEvent {}

class GetSubOrdersEvent extends HomeEvent {}

class GetAllCarsEvent extends HomeEvent {}

class SetDriverEvent extends HomeEvent {
  final SetDriverParam param;
  final VoidCallback onSuccess;

  SetDriverEvent({required this.param, required this.onSuccess});
}
