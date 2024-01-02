part of 'home_bloc.dart';

@immutable
class HomeState {
  final PageState<Iterable<Polyline>> polylineState;
  final PointLatLng? currentLocation;
  final PointLatLng? lastDestination;
  final String? lastOrderNumber;
  final Marker? currentDestination;
  final Marker? currentOrigin;
  final Completer<GoogleMapController> mapController;

  const HomeState(
      {this.currentLocation,
      this.lastDestination,
      this.lastOrderNumber,
      this.currentDestination,
      this.currentOrigin,
      required this.mapController,
      required this.polylineState});

  HomeState copyWith(
      {PointLatLng? currentLocation,
      PointLatLng? lastDestination,
      String? lastOrderNumber,
      final Marker? currentDestination,
      final Marker? currentOrigin,
      final Completer<GoogleMapController>? mapController,
      final PageState<Iterable<Polyline>>? polylineState}) {
    return HomeState(
        currentLocation: currentLocation ?? this.currentLocation,
        lastDestination: lastDestination ?? this.lastDestination,
        lastOrderNumber: lastOrderNumber ?? this.lastOrderNumber,
        currentDestination: currentDestination ?? this.currentDestination,
        currentOrigin: currentOrigin ?? this.currentOrigin,
        mapController: mapController ?? this.mapController,
        polylineState: polylineState ?? this.polylineState);
  }
}
