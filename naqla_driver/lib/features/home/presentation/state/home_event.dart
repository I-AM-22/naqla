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
