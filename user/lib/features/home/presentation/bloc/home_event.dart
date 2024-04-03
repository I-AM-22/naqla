part of 'home_bloc.dart';

@immutable
abstract class HomeEvent {}

class SetCurrentLocation extends HomeEvent {
  final PointLatLng location;

  SetCurrentLocation({required this.location});
}

class ChangeLocationEvent extends HomeEvent {
  final Function(LatLng latLng) onSuccess;

  ChangeLocationEvent({required this.onSuccess});
}
