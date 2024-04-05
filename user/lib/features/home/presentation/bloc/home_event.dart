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

class UploadPhotosEvent extends HomeEvent {
  final List<File?> photos;

  UploadPhotosEvent({required this.photos});
}

class PickPhotosOrder extends HomeEvent {
  final BuildContext context;

  PickPhotosOrder({required this.context});
}
