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

class AcceptOrderEvent extends HomeEvent {
  final AcceptOrderParam param;
  final VoidCallback onSuccess;

  AcceptOrderEvent({required this.param, required this.onSuccess});
}

class CancelOrderEvent extends HomeEvent {
  final AcceptOrderParam param;
  final VoidCallback onSuccess;

  CancelOrderEvent({required this.param, required this.onSuccess});
}

class UploadPhotosEvent extends HomeEvent {
  final List<File?> photos;

  UploadPhotosEvent({required this.photos});
}

class PickPhotosOrder extends HomeEvent {
  final BuildContext context;

  PickPhotosOrder({required this.context});
}

class GetCarAdvantageEvent extends HomeEvent {}

class ChangeSelectAdvantageEvent extends HomeEvent {
  final CarAdvantage carAdvantage;

  ChangeSelectAdvantageEvent({required this.carAdvantage});
}

class GetOrdersActiveEvent extends HomeEvent {}

class SetOrderEvent extends HomeEvent {
  final VoidCallback onSuccess;

  SetOrderEvent({required this.onSuccess});
}

class SetOrderParamEvent extends HomeEvent {
  final String? desiredDate;
  final LocationModel? locationStart;
  final LocationModel? locationEnd;
  final int? porters;
  final List<OrderItemsParam>? items;
  final List<String>? advantages;

  SetOrderParamEvent({
    this.desiredDate,
    this.locationStart,
    this.locationEnd,
    this.porters,
    this.items,
    this.advantages,
  });
}

class UpdateFormPhoto extends HomeEvent {
  final bool add;

  UpdateFormPhoto({required this.add});
}
