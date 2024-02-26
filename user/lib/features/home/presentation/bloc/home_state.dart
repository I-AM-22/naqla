part of 'home_bloc.dart';

@immutable
class HomeState {
  final CommonState<Iterable<Polyline>> polylineState;
  final PointLatLng? currentLocation;
  final PointLatLng? lastDestination;
  final String? lastOrderNumber;

  const HomeState(
      {this.currentLocation,
      this.lastDestination,
      this.lastOrderNumber,
      required this.polylineState});

  HomeState copyWith(
      {PointLatLng? currentLocation,
      PointLatLng? lastDestination,
      String? lastOrderNumber,
      final Marker? currentDestination,
      final Marker? currentOrigin,
      final CommonState<Iterable<Polyline>>? polylineState}) {
    return HomeState(
        currentLocation: currentLocation ?? this.currentLocation,
        lastDestination: lastDestination ?? this.lastDestination,
        lastOrderNumber: lastOrderNumber ?? this.lastOrderNumber,
        polylineState: polylineState ?? this.polylineState);
  }
}
